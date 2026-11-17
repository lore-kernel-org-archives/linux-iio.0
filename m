Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913802;
	b=WcmHI7RRgdTpePLfHon9M0mieOd1sbCXCung0nDPQhFmKV+7rGF3WUHxbjKAiusXqswI
	 8a0SAf+CKvhBJVxVugvC9RTf9sss5yBIw/FOaaHT0rVBGyO/yc27UPxhVdSRF1LIA5PRz
	 LXFhYDVw2TkxL/WnO+iyrUpddtabU8q30Gae/hrGEv80SwSfy8gj1hr1P0dpwkGhQYIST
	 6LRGeqbpMI7jPyI4tv3K1XSexAdKOh50v2IeVf8AAN1kUIyFj11syXraCGGJmFIyX2q2g
	 e0RBXRUwHvpd6ktBDLcEVLd0YqQLSHBdx1DhDjnVcF2psgKdDK24Glaad1lIspzXGeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3ISBPwk8qHeSYB//k/N7PsmIgbDqodoqheEua22OWtQ=;
	b=jWuF20OfBs9a0801kfuUY5DPwyvxG4USeMq8RaEZT0aOgQFXYYKtgi7l7bIIzeQkKztR
	 3Vn4PTRVu1fWc43qz/mbSW1yp78UIzWmeaX6IcMt7RLputHtEi626S2EhTSPpnMriXyta
	 PTb1Ib8gDlmuhr8rru7Cpd6R7EjSdlWXCcdUuljZGxUSvmHj9gR+UZ7tXbUEzFJbWtjlN
	 0iOJzPifERbl2xvQKAdEQPudbmXZCaHgIpMk30hVhYZ8NuvuhdxfQt0v3j9lD1FT3JdsH
	 rs83IRU5+QQPIfKHqYUifFRRnyQifNeYsAmdWh3TE92SL9O8MPhnIhfS4e0FKoTz4/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oc6zcNdi;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F86606A323
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F86606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oc6zcNdi
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so11444412eec.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 03:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913801; x=1795518601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ISBPwk8qHeSYB//k/N7PsmIgbDqodoqheEua22OWtQ=;
        b=Oc6zcNdixWMFm76SSUKnhzYY8q3Nwt6oTBJekaFpoPYmoHhI+COcHchpx4Jr95eMTQ
         Nfd63rfs8Yo0TLi3ipADabObZ9bGEr0JC0cfc9xthBZsQOAA88TPcgCm3jM0udHc189f
         I8InqFADNT2BtjxtOItrIKnfBMX5cYATYNzllUrxmPCNnTyIkgQOg+n6GAFKrwdZzRtY
         eNribh2r/hC2ZKT1sEEoT/Tq3lbGEFPj56TRm3zPslCvlvFwo/SlSK3acvyKhb0xxDat
         uM1Bk/qca/JjR2qEP7YCPmfe7S2+32OFa9upCuTC+L3zgKANaT2jh8Z+qXMSSsMFUFoq
         +RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913801; x=1795518601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ISBPwk8qHeSYB//k/N7PsmIgbDqodoqheEua22OWtQ=;
        b=gvQG5CMnvJFny4E2OfeJVsQYPa2r30bzTDbUOcvy3qmBBnDInk44aBljIBlnbZ6llQ
         pZZ7dYyMorzT8sr95OYmAVKfKoMrm1hlqMVml27Mn7ZAHxH51FoAwr4xqPN1fBW3s2zO
         8r1MEPxDFEvtWTXp6o3vvj7wggU75D6Wh3Hz/M0F7QUxcLogWGfV3qcWfQgQJ26Om411
         lMB10cJRcefGzs2G1rizOk8U6eXeNCsXjuNk1CdvfQV6BlCxmtseCRL2/8lcAgRgD7YH
         2b1PXV+gQGRnm9Exmya6VVzOCcs4Nd2hQsE2ueQ3G9vcO1gcUfsIwsgorAwYuBTPG9ll
         ZPmg==
X-Forwarded-Encrypted: i=1; AL+hErEC3UKBbRiXuA5dus6jl+klV3f8KH5h3ncAsaVMQNBg974M/zuK51sJgfmfTqWGlS2b7w6bhse32FU=@vger.kernel.org
X-Gm-Message-State: APuU4Z84xik5QngvNM8a2VrNu9DmuZM96NCtGjUnhDIV4XvetmTXm7zz
	zGLvrzJRv+zFuM1Em0jjXMTIB21Z/bJzlEbI20seiMKBibwFq7KeljT1
X-Gm-Gg: AZFdTZeT6mjj5sxDPaRe2apQHIKo3Be4byGGgZnQ2GZmO2Cab5TGPlwjekwBYaeeUVT
	oqYwEKuDG872IRnGm0alsibtKbq4QKkZjasZLW137p+l1AADyAgP/rahEcLDffGrjPibf9EVyL9
	XZsSPQnFg2nTgyT61Z7J5HJkkUEI9FN3LrycLIF2g0fyQ419H7z/R/Vve0kSYuYG8tXqo+kILRK
	WJBMUgcbOSn2Dr68dhlx+akdx+dvj3lvK/Czo+80qcBJXw3uoIPuj8+/AsOciP36R9lLhl9cTRh
	xwQBNvRfxT+X82WNEa/BVoWOwEuIJhijG/JXCdWOTudMm9Px5LH8LwP1L1VaP1qMCNpqfCpTv1N
	fklyJxXubXC2Nub9s1xqRbN4jTUsay0p3KewJMtKsGITzGGstr0hyi9wQvoX5UhcZsrPpgp1AOc
	F7Jmb8Te6XI8U79d/ccNW/itqIyDPDbxuY8ym7Ly4nXfMSCABRy8zW3BjulW4v8c0QYBOuMX8z5
	am+Ths4nriwTzS5zRQW52umdZu2SeTgQ4DHp8vu8n0JOECzZqSNlzmzMhl2Ye+U0to8k0Rg9dix
	17PNDx/XKEvh8EA6+/U0yZ0iXuXaf9HuTom36PyRFzIyVMIZPoLn5fTRobhcpugaPvropYQadUi
	Y8iHaxJeZVpVKFcg4RXaZeCAX97FvNjwwWy45ros6l/T/besSkhAlHpkE9tIkNnw2Bti8mFFJjm
	m3AJ3IK63fIIJTJh0jwtcJxx5TdBYkgv5QYIJ94Mnr+Zs=
X-Received: by 2002:a05:693c:87d6:10b0:380:c2ee:4035 with SMTP id 5a478bee46e88-380c2ee41bfmr2990992eec.16.1794913800913;
        Tue, 17 Nov 2026 03:10:00 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-381a55555dbsm5560475eec.10.2026.11.17.03.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:10:00 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 2/2] MAINTAINERS: add a reviewer entry for the Semtech SX9xxx proximity drivers
Date: Tue, 17 Nov 2026 16:39:35 +0530
Message-ID: <20261117110939.214932-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117110939.214932-1-kapoorarnav43@gmail.com>
References: <20261117110939.214932-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Semtech SX9310, SX9324, SX9360 and SX9500 proximity sensor drivers
and the shared sx_common code have no MAINTAINERS entry, so
get_maintainer.pl only lists the IIO maintainers and reviewers for them.

Add an entry with me as reviewer. There is no M: line, so maintenance
falls back to the IIO subsystem entry, as Jonathan suggested [1].

Link: https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/ [1]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0017755f593b..94797863d881 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25448,6 +25448,19 @@ F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
 
+SEMTECH SX9XXX PROXIMITY SENSOR DRIVERS
+R:	Arnav Kapoor <kapoorarnav43@gmail.com>
+L:	linux-iio@vger.kernel.org
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
+F:	drivers/iio/proximity/sx9310.c
+F:	drivers/iio/proximity/sx9324.c
+F:	drivers/iio/proximity/sx9360.c
+F:	drivers/iio/proximity/sx9500.c
+F:	drivers/iio/proximity/sx_common.*
+
 SENSABLE PHANTOM
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-- 
2.53.0

