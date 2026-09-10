Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A83A5422
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074898; cv=none; b=PZvbus6YwIfpQ0S8K4yXrwmYXMSlWjJ+KnXODQozP5OFvIT4t/fhs2YzjkZrTr5cBWN4UtLEK6iiDZZZOkk5bTvqDM8YRfNgol3C8nX6Iep4eNIYiniZTkjPaIpzpodXhYFRxZpcbp/9kiCnLLjho8Zlcm7TAEV3gnS9bUrU7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074898; c=relaxed/simple;
	bh=4mIrQseGaDrWXOkGj+VmtS3xT3kzP+fkmkBCoKYUU7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8XxQzp3Nu1duDuSFxVIvwgTrTeDdJi6fQwG/XxSq03fjsp+wuUPYrmU9GI5dhGUvIrH5ssoJ202vDC8W0+Uhp/Xel9IWSPqvuccT/lkPwv1kQ2mlAKvObGG20iEz1RXux2KWrVoIavNB0hpkQ6I4brQC+3q57xv7hlyWbYoJAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BmtCe44l; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BmtCe44l"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-495c49f8eccso315027b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074884; x=1789679684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxj4NP1Iiq6S7QGXGCteoLSsgcXgpsaLfh9MJtp5gfo=;
        b=BmtCe44lKd4Es0fmw33kmaqs32b333/l7tIcJ+hv2+V4QBuBwvtG4hr9gm+x88F+At
         mODX9PKF5bkwgC9S5kf3jp+CUcT8aV/T2XC5jVPMXxgV2yyQ0OAQlFuaiyYEplq4n8HW
         Pje5ySQ56H5jnxewz8FYlZzsY5Iw8AcetHIPRt7x69LHG4pBH8lvPQLygMeNBypREyeI
         Q0obBapCP2ma/Q26ti1G2xS8AzeTiuaV97CJ6xk2dp7DiYxj44dAds+Op80CmV+q1gsh
         7HvI7gVSBteDIQ5p6NibskIOeGiNLbce36a82aEaTdw1bzr4VbOG9xy57kC8TG/0OCk/
         FG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074884; x=1789679684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxj4NP1Iiq6S7QGXGCteoLSsgcXgpsaLfh9MJtp5gfo=;
        b=RkDawcDVaqmo7DLyWId7LDHjZtu5qO7szkkUatdg286uSgypoFNk2vJVt8KLzNDWUL
         w0LBVv49snkWL0PwoAXcZOOAFqTQyiFXcihlmDyQYfiJAan6XLDpHRYVL9oP1OoAEdsC
         vJbEL2v44QnTrU90nnQxEkoCEk9VA9myrppfCgxs3/dFOySCEM0g0xbm0umxU4EHJOsj
         RnpCRNr+UswHIHcNEDXIAplL3AbgJKphV8khKH8kwq6gqe5mPWQNj/zs5vNAUOooTe9u
         /+NmlJMlmbtXoQPVvDK6YcK9RR/ic14Zcp8LeDkbI2K49AEJL0tmfoW7um+ZdU+5wniC
         N+PA==
X-Forwarded-Encrypted: i=1; AKwUvBxjjsnzSEAw94v3XgY2yeDQWvF/dH3l/Fh6Cy8eh5+Y/LBgH+YtN/wPlYJkOpazD3zblCyrrMqdEZI=@vger.kernel.org
X-Gm-Message-State: AFuF++nrhLchiUuAKSTytQGSAlaFCiloHH9OfwYJTyC/RXZsruxTBDgw
	C8aofr20WtpWyOH36aR7eX9LJlm9YDRY17txgDdpH/Y6dtaZFw9cZhnMIGtZNrJ2sEg=
X-Gm-Gg: AYBFou2mt6fFbJ7O1K5MohC3YNRZP5dP14ApgqbXfEggg1+vi5kvSn4udki5RnQIPwy
	6S81vCimdL8Aj0W6ZfyVGozD7ppJpkqCJSoJSaw7/viznKag+vANQbjjR8qLBaddOyYb7J+2yWB
	TtLXUf1X30xaauyJ6DJBFXP9eby38tkOPVPRTnl5Y1qk6dJ1Lk2duOo1ZjYg0i4HOgp5NwRlf4b
	pg+qYX2Dpw6Ocv9zZmaadwToUWeKzrP+S1fuLvlZznKz2jnNMpFY12Lqv18MZQjYBKW2WXhBpgb
	9i7Ipj9+MbI/x04KM2DnVa6OnMPqq+Ks1hh2Ax0FYCnwPTQ77gvEBW3esdc58yApD4M9NEni+Ly
	EAbhbwHGUG/bqNd26RFkAupNtTbfCIXm806XmJpC8QnPCSf4VE/G3PEW8QAT8f2B0bRvlsZk5AM
	y4Qwp7OHTknjMj6ZQ7mH5bzA0k9JysIAH96+V7lyx7yZK4ag/10EUqi27y8nNk+58DqaaI4kdhw
	yLf
X-Received: by 2002:a05:6808:c166:b0:48c:4c00:596a with SMTP id 5614622812f47-4c319341b39mr666976b6e.5.1789074883692;
        Thu, 10 Sep 2026 14:14:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:43 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:07 -0500
Subject: [PATCH v3 08/10] iio: ABI: add sinc4+sinc1+pf1 filter_type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-8-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4mIrQseGaDrWXOkGj+VmtS3xT3kzP+fkmkBCoKYUU7I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox2gsnyZz5eiy3zeJH6x3A/wXsvKhVqHWdGmj
 BC9k5l4DsWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdoAAKCRDCzCAB/wGP
 wA3HB/97UdmxWYF1wSRrDhaegBfjz9KItpeYC9uVju1XB8Y9G0pDaCH97QBz7qKciVFvnSWf7dc
 kZm3B/sTvc4P3ajFHohL83ZmP4luQs2hn1YrtsHSASLoMfdKF099CzY/WccG0xWDzlQBLZq1dZR
 NnR++mG1HU37fQ7hn2aJWQOc2I0dpc6WgJte0ru6DeclKw8n+y9NUcapB9gZb4pcd/H3WaWWG9i
 GXGLLJNSbZSWkOAfTZs1VBZTKCYH3uABjvYLBxuQ2T3S1Nbt/G2cJ8ehw6lkXujF3wxxaD4Jtma
 ua9W7NT7F/j9NNJ+XtQ2Gf9TGAi7Vj9802G/n0QWqBM9qo75
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document "sinc4+sinc1+pf1" as a valid value for the filter_type
attributes (used by the ti-ads112c14 driver).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a4f5595722ad..a8e1cb8e7490 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2380,6 +2380,7 @@ Description:
 		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
+		* "sinc4+sinc1+pf1" - Sinc4 + Sinc1 + device specific Post Filter 1.
 		* "sinc4+rej60" - Sinc4 + 60Hz rejection.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
 		  performance

-- 
2.43.0

