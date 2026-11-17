Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924346;
	b=jRwfeODbM1bAb7HPr8DNRg14gsqwiNtL+0NjRoIZVpXLcKoqAcZvH0dZMY1cL74CyN2I
	 L/dQ7txYNqAlmzKcM4+NZAtg/ziIpUG+mmZaV0g9iIGWWnFmxUPNmj2HSDKP3+Cd+K1qQ
	 98X7XKlyluba1uwgpq+FkXTqmZbQRE2BpNQmWgndXAg7rk4YMBycUbTDbyJl9cCxGNNiz
	 hwbQt2mSTOuclM5PyCuk4vUN6LM3NAG2IHZKzi5PUztzr/OI2jZNkkXGr1HmkgDlrZMpw
	 GBbf3Ip7Qg/ChDkxEZRAIQV0Fmw6LhWnzOuInUOFJJzubMNN2j+ICftPDxryOqRz7Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=evA50aPqc3DFC7OnsafBK/uchzbfQmhK+e2vPkGMqcw=;
	b=r2PQohMLWP+4o0I3WEiRzMelzyicz1jOXr7zoE5xrK9+ybPM6tq4INEKsh4TB/iMAaq7
	 KnVcwWjhzmDRfPjnp3JkFbhHbNYUPCpjeXbfvnpb64tHwjRVi6bcJP+kShwIONlyL9pxr
	 BaEG/POvWsQ7Six0aZExXBKwtkT4/MaUdluKnlyQZTK+wm6qDPvEsjQ2uTOdjOqMT9H+y
	 MKLm64GYYqNZOdEPZspB3KhBmJmNxKpHfFDMB0SNp+zHv/HEtIrOI06fcC1fR3dQF/Ftz
	 Ei+hsbhyIeId2jEklmag8hO9RagLVYw0DNm+68mL9G52lHFAxaWjeggpbvAkJftZyRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzeC55U9;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3417606A885
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 14:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3417606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzeC55U9
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-49412eb1474so2484710f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794924344; x=1795529144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evA50aPqc3DFC7OnsafBK/uchzbfQmhK+e2vPkGMqcw=;
        b=fzeC55U9iGh4cklrPvdx6XXEvtJpUKOU+2onpFZAGeHkbNUT2+n7jsdd0mi4p9lsTr
         B/aQWDbOhZL8xeNN3bsdyR+oEh44dvqtVOsCMd8dJL51hvYThwkraxHdaoPZEmzLWA19
         a93iPMHtP/2kRXw4RCrC++dinfPkFrlH1Amnii3+/UedzqSTXMD5Wvqjfi7uJnjt5xIm
         FSjV0UQlQuSQr81L21cfBKtSZrxGL+Q8p3b5SIOWg1A3ozF0DLrjgw3U3bSLxnGC9HS5
         i8Ri3jY5Y4beuqSx9uVBXqceU24GyvZhc4wq5ueLHgDKt7HJAOrW4WjMeVC3AiX64Dr2
         ncUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924344; x=1795529144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=evA50aPqc3DFC7OnsafBK/uchzbfQmhK+e2vPkGMqcw=;
        b=Po0VXA9VjJ4fplgNuLZZHicz8iF1Vfxi+92+v06Z93QHarhT5Z3+Kz92F5M9ybklO7
         EM3MnzJodjjLCGsmn9pTLENOno/es5wTK+3Hz3xO3LX8wTmOAlUGoQSYc2cARxd4FMhk
         7JeIYd9OVxjszRi226EQ3FIi9U7q95wpqhFxq2189N0Ou+h4xckZ9abI7J7QitHWJb8U
         aOzVmhYRphU1bA/+rCCWm5BbD8lRfdAhwVrUuAg1P3zBCLTnoa4n/LaZfJS8/DiGDOWQ
         wKRXtTZ3tlpw2lf8QQsvchKGDD8Ak4SV7qlqpQcBhWvEpHNq44kSQv67dmep0HIgm900
         tS9A==
X-Forwarded-Encrypted: i=1; AL+hErEw1dM2E4LdQHDcTL+8gGIkH72LRTxTI7ZjpIMTqVG9W2EnDPX7CMbwKZ7zr64+mILwOpU0sDs/b24=@vger.kernel.org
X-Gm-Message-State: APuU4Z8effS/zABC4Gq2e3gU3VNtiLf7hy+bbsdfBJRFfU0G9ZPY6+Ec
	20MYedGmRNFfJ6Su/PBdrX8SdFio3QTdi+XxYt7anIXLtH/P04n6adnF
X-Gm-Gg: AZFdTZca9BJ0V72HP0nPV4ipYwjb9W/0IRvJA+5Yk3c0cyHY94kmOXZw+stfcAs8TSt
	cp5DE571iSsNG7+XTsjTFLEs5ULVEo2hYvt3vMX1nPSVYGhO0BEwlwvvVA90mYcqkb4eLMC/0gH
	IkYTL61/EMMk6bBMDwbrNaEMrLJtc1h8g4uejZsbwJqfdmLhJeuG/s3uZ3uxiGTbZQvOyPH3oqA
	GYnhGQ3FNmiHVsfeTVooeGQRTN3kk4isxtV+xqGARfUpJCKmF8Xx2VcoNNFvZQ4pS/QOpWdmK21
	HHh3mzb+W41sJzHReL2hmhSNso8KKofWcxt0Aw5QQEHTuuHQc7OF18/z3RGTa82TEbDnjh6t5uX
	1rjzZT1QBwFvDq78sotlyCb+aLiFdoq816RVoSTVtEdteusFRJr1kOvpN3vJgXLaEIOli/2yaVt
	BkgfCvnwa/2wW9x6d4cL0ZLVJBF3m7TTQ0FsQLORsn+9DtdB3Tla21Rhqzoe0p5e3EIl7TVo+PS
	FR0VhcFDgMFHtx/Wlq+zuw2Q7DqWoFuyhITKBb6MNEFuaIBDbMj5mTDYmiTmS1gZmbMWmNyuxb+
	U73mEaHioumFoCsbbBnxmojAiFzxNC1gxPC8YQ==
X-Received: by 2002:a5d:59c9:0:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-49c6e68da9amr31383557f8f.5.1794924343919;
        Tue, 17 Nov 2026 06:05:43 -0800 (PST)
Received: from fedora ([154.183.162.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm2623032f8f.8.2026.11.17.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:05:42 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 1/3] iio: adc: at91_adc: fix NULL pointer dereference on trigger remove
Date: Tue, 17 Nov 2026 16:05:08 +0200
Message-ID: <20261117140510.391907-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
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

When the "atmel,adc-use-external-triggers" property is not set in the
Device Tree, at91_adc_trigger_init() skips the external trigger slots
and leaves the corresponding entries in st->trig as NULL.

In the error rollback path of at91_adc_trigger_init() and in
at91_adc_trigger_remove(), iio_trigger_unregister() and
iio_trigger_free() are called on every slot without checking for NULL,
causing a NULL pointer dereference whenever an external trigger slot
was skipped, either because of a partial allocation failure or because
the external triggers are simply not used.

Skip NULL trigger slots in both teardown loops so that only triggers
that were actually allocated are unregistered and freed.

Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0ac74ad92fca..c7fc06214c05 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -660,6 +660,8 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 
 error_trigger:
 	for (i--; i >= 0; i--) {
+		if (!st->trig[i])
+			continue;
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
@@ -673,6 +675,8 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 	int i;
 
 	for (i = 0; i < st->caps->trigger_number; i++) {
+		if (!st->trig[i])
+			continue;
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
-- 
2.56.0

