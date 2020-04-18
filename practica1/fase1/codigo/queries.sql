
--#&&
SELECT c.nom, AVG(100 * (m.price * 7 + m.weekly_price) / m.weekly_price) AS savings
FROM city as c,
     money AS m,
     host_info AS h,
     apartment AS a,
     neighbourhood AS n
WHERE c.id_city = n.id_city
  AND n.id_neighbourhood = a.id_neighbourhood
  AND a.id_host = h.id_host
  AND h.host_identity_verified = true
  AND m.listing_url = a.listing_url
GROUP BY c.nom, h.host_identity_verified
ORDER BY savings ASC
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
FROM apartment AS a, money AS m, info AS i, host_info AS hi, properties AS p, neighbourhood AS n, propertytype AS pt
WHERE
        a.id_neighbourhood = n.id_neighbourhood
    AND a.id_host = hi.id_host
    AND p.id_type = pt.id_type
    AND p.id_apartment = a.listing_url
    AND m.listing_url = a.listing_url
    AND i.listing_url = a.listing_url
    AND p.bathrooms::float > 1.5
    AND n.nom = 'Port Phillip'
    AND hi.host_response_rate::int > 90
    AND p.accomodates = 6
    AND pt.nom = 'Apartment'
    AND i.minimum_nights <= 5
    AND i.maximum_nights >= 5
    AND a.amenities LIKE '%Balcony%'
    AND price IS NOT NULL
    AND cleaning_fee IS NOT NULL
    AND security_deposit IS NOT NULL
ORDER BY precio
LIMIT 1;
---------------------------------------------------------------------------------------------
--#&&
SELECT * , age(h.host_since) AS diferencia
FROM host AS h
WHERE '2019-12-30' - h.host_since >= 1825;


--#&&
SELECT a.street, COUNT(a.listing_url) AS num, AVG(m.price) AS precio
FROM apartment AS a, money AS m, properties AS p, propertytype AS pt
WHERE a.listing_url = m.listing_url AND a.listing_url = p.id_apartment AND p.id_type = pt.id_type
GROUP BY a.street
HAVING AVG(m.price) < 100
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
FROM apartment AS a, money AS m, city AS c, neighbourhood AS n, host AS h, host_info AS hi, properties AS p, info AS i, propertytype AS pt
WHERE  m.listing_url = a.listing_url
    AND i.listing_url = a.listing_url
    AND hi.id_host = h.host_url
    AND h.host_url = a.id_host
    AND p.id_apartment = a.listing_url
    AND c.id_city = n.id_city
    AND a.id_neighbourhood = n.id_neighbourhood
    AND pt.id_type = p.id_type
    AND c.nom = 'Saint Kilda'
    AND a.amenities LIKE '%Kitchen%'
    AND hi.host_verifications LIKE '%phone%'
    AND pt.nom = 'Apartment'
    AND p.accomodates >= 2
    AND p.beds >= 2
    AND ((2 * 2 * m.price) + i.cleaning_fee + (i.security_deposit * 0.1)) <= 5000
    AND i.maximum_nights >= 2
    AND i.minimum_nights <= 2
GROUP BY a.name, ((2 * 2 * m.price) + i.cleaning_fee + (i.security_deposit * 0.1))
ORDER BY price
DESC;


