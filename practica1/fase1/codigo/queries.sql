--#&&
SELECT c.nom, AVG(100 - (m.weekly_price * 100 / (7 * m.price))) AS savings
FROM city as c,
     money AS m,
     host_info AS h,
     apartment AS a,
     neighbourhood AS n
WHERE c.id_city = n.id_city
  AND n.id_neighbourhood = a.id_neighbourhood
  AND a.id_host = h.id_host
  AND m.listing_url = a.listing_url
  AND m.weekly_price IS NOT NULL
  AND h.host_identity_verified IS TRUE
GROUP BY c.id_city
ORDER BY savings desc
LIMIT 3;


--#&&
SELECT a.name, (m.price / p.square_feet) AS price_m2, COUNT(r.id_apartment) AS critica
FROM apartment AS a,
     money AS m,
     reviews AS r,
     properties AS p,
     propertytype AS pt
WHERE r.id_apartment = a.listing_url
  AND m.listing_url = a.listing_url
  AND a.listing_url = p.id_apartment
  AND p.square_feet != 0
  AND pt.nom = 'Guesthouse'
  AND p.id_type = pt.id_type
GROUP BY a.name, price_m2, a.listing_url
HAVING COUNT(r.id_apartment) > 200
ORDER BY price_m2
    DESC;

--#&&
SELECT a.name, a.listing_url, ((m.price * 6 * 5) + i.cleaning_fee + (i.security_deposit * 0.1)) AS precio
FROM apartment AS a,
     money AS m,
     info AS i,
     host_info AS hi,
     properties AS p,
     neighbourhood AS n,
     propertytype AS pt,
     amenitiesapartment AS aa,
     amenities AS am
WHERE a.id_neighbourhood = n.id_neighbourhood
  AND a.id_host = hi.id_host
  AND p.id_type = pt.id_type
  AND p.id_apartment = a.listing_url
  AND m.listing_url = a.listing_url
  AND i.listing_url = a.listing_url
  AND aa.id_amenities = am.id
  AND aa.id_apartments = a.listing_url
  AND p.bathrooms::float > 1.5
  AND n.nom = 'Port Phillip'
  AND hi.host_response_rate::int > 90
  AND p.accomodates = 6
  AND pt.nom = 'Apartment'
  AND i.minimum_nights <= 5
  AND i.maximum_nights >= 5
  AND am.name LIKE '%Balcony%'
  AND price IS NOT NULL
  AND cleaning_fee IS NOT NULL
  AND security_deposit IS NOT NULL
ORDER BY precio
LIMIT 1;
---------------------------------------------------------------------------------------------
--#&&
SELECT *, age(h.host_since) AS diferencia
FROM host AS h
WHERE '2019-12-30' - h.host_since >= 1825;


--#&&
SELECT a.street, COUNT(a.listing_url) AS num, AVG(m.price) AS precio
FROM apartment AS a,
     money AS m
WHERE a.listing_url = m.listing_url
GROUP BY a.street
HAVING (AVG(m.price) < 100)
ORDER BY num
    DESC
LIMIT 3;

--#&&
SELECT rr.reviewer_name, rs.id_apartment, COUNT(rs.id_apartment) AS num_reviews
FROM reviewer AS rr,
     reviews as rs,
     apartment AS a
WHERE rr.id_reviewer = rs.id_reviewer
  AND a.listing_url = rs.id_apartment
GROUP BY rs.id_apartment, rr.id_reviewer, rr.reviewer_name
ORDER BY num_reviews
    DESC, rr.reviewer_name desc
LIMIT 3;

--#&&
SELECT a.name, ((2 * 2 * m.price) + i.cleaning_fee + (i.security_deposit * 0.1)) AS price
FROM apartment AS a,
     money AS m,
     city AS c,
     neighbourhood AS n,
     host AS h,
     properties AS p,
     info AS i,
     propertytype AS pt,
     amenitiesapartment AS aa,
     amenities AS am,
     host_verifications AS hv,
     verifications AS v
WHERE m.listing_url = a.listing_url
  AND i.listing_url = a.listing_url
  AND h.host_url = a.id_host
  AND p.id_apartment = a.listing_url
  AND c.id_city = n.id_city
  AND a.id_neighbourhood = n.id_neighbourhood
  AND pt.id_type = p.id_type
  AND aa.id_apartments = a.listing_url
  AND aa.id_amenities = am.id
  AND hv.id_host = a.id_host
  AND v.id_verification = hv.id_verification
  AND c.nom = 'Saint Kilda'
   AND am.name = 'Kitchen'
  AND v.verification_name = 'phone'
  --AND pt.nom = 'Apartment'
  AND p.accomodates >= 2
  AND p.beds >= 2
  AND ((2 * 2 * m.price) + i.cleaning_fee + (i.security_deposit * 0.1)) <= 5000
  AND i.maximum_nights >= 2
  AND i.minimum_nights <= 2
GROUP BY a.name, ((2 * 2 * m.price) + i.cleaning_fee + (i.security_deposit * 0.1))
ORDER BY price
    DESC;






--#&&
SELECT h.host_name,
       SUM((1 / m.price) * (1 + (hi.host_is_superhost::int)) * 8 *
           count(hv.id_host)) AS score
FROM host AS h,
     apartment AS a,
     money AS m,
     host_info AS hi,
     host_verifications AS hv
WHERE h.host_url = a.id_host
  AND a.id_host = hi.id_host
  AND a.listing_url = m.listing_url
  AND m.price != 0
  AND h.host_name IS NOT NULL
GROUP BY h.host_url
ORDER BY score desc;


--#&&
SELECT r.reviewer_name,
       (SELECT SUM(CASE
                       WHEN (LENGTH(re2.comments) < 100) THEN
                           10
                       WHEN (LENGTH(re2.comments) > 100) THEN
                           15
           END) as pun
        FROM review AS re2
        WHERE re2.id_reviewer = r.id_reviewer) AS points
FROM reviewer AS r
GROUP BY r.id_reviewer
ORDER BY points
LIMIT 10;


