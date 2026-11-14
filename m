Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676119;
	b=jwnhYLHFXaHht6erZrjKVBNwUKICSCcvHqOXsZfxzxGXM6kBZ6pv2pVL0IEqsccnlYKI
	 qx5ctCMFU7Uzk/XEFtXd6CZcCmeiZ5isXOyvTghNFHbyuMSAWAA+/wxJVpKeU8WwS5YJZ
	 2BQOmTCbynWvQX0gtIfCRBFgEPFAv6p+BqN54zXESqE3NzwKClO8/XmKSzSnY2nXA4l8A
	 L/FPyeTsIZoKhZ5BNfH8bv065QAarKMZTrKSkE4tlQW99glwrwsaxB1LEARzi8pcBKAiD
	 w6Uof8nP8LpQ53DOG20PaJ7e8DQGhpDm+esoVpIrlCHdAYteCyr2HNW7wrdqqQqb7/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676119;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Content-Language:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=lYOovXuhoqNFUTUA5tPpHQu+Mj1p1clmjohXVH7Jssk=;
	b=qE41nG16EomplB9QT8fsoweyFBsA/WyP2GYJg2FYupFU6JOb2Hy/ZiEfNksLx3Ijg1up
	 54IdQ0WVriOt1s/4Uey2DcmUQqsYtdjA6HuAWUAn306Dc12Zb5Tq7W9NCKOQYVe/xEIyh
	 H61dkL6NWB/ynqBGIw3lk0ayNW5dd09c9Zef+MZUv/RzyQw+SfU5wpPGJwUPPTV8EQe75
	 vslqUMs0j5kNcrPQbMxCuLNqts/peWBdIL85VALEaUYBkvA/SxnhiC42bS1fg2UrUhv6J
	 Upc3xm9ePiaHvLsjAP/ZFKlgIWiXkQSLuFtG9Ac5qshxhV9QMgzRa0ak6vpah4/E1NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NjBQcUes;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38691606A330
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 17:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38691606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=NjBQcUes
DKIM2-Signature:  i=1; m=1; t=1794676116;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:UdfJjvFMa8YwIX/KkntX4j0yEmwN
   NEEXLZup7PF0SpktgYmDJ+VYt2VCd2LIzD2XJkliDu5uPLnINhIMy/p+zMXwjZkG0i9VT1ze6+a
   4ihf+C4xZcjnr7Sd/FmHPoETxWj/94GOKhGxuPm5lNtWVzC2mufNXGC437ImfPx5QjWNyml3p/P
   m7y0dVkfGamb8l4hct8r5GKClBegMWjgXKvrm34gMsmlGe4qQdN5QxNFN0S7oBbZfSPTVfQQN77
   I84jCLo3ZjqfV4KOJv0CzmzBMYSyqqYUH9MGoYgbOU1QsO+ImpjWpTjRsdT+ZfdKjfJza4Z+QsN
   YXb8rJMY0z2Kew==;
Message-Instance:  m=1;
 h=sha256:
   46G8Y5SeP3gfbv1BjpYCd/EujO3GxEwgvVFuxlPNyio=:
   NPXBH/nBgEWZYAmOqEwpyNLhx/a+1hhohgQ+KNjHEHg=,
  sha512:
   JOvkUQs9pU7ojfbDJfk/fuQKeonWyaLDFgKm0+nIw9f46LgFzZElK+AjOxXe5LbxT8A9Ff690EgI0zoaFx1Sbw==:
   YsaR99eRAG6yHs1jQ/wI0wHiUSfyCl18pC64wFVRELFypPrq7TITNEqARfEI1w4Xd/zDlIQhpqJo+1YtYjqFsw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794676095; x=1795280895; i=markus.elfring@web.de;
	bh=lYOovXuhoqNFUTUA5tPpHQu+Mj1p1clmjohXVH7Jssk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NjBQcUesAYwN66wRMSUIKfrpAycQFQZHaIY1x5+sBO30Q+AO3z2b0OLCkIFlhsOn
	 Bjk9cmVY+ddZnNl0dAtz/WDgSiFPoCQjeDZxSKAokLauJhGnedTKmdJv3+AdudAH+
	 qZ90Z7wp2nuS40VPzZi0LKNGtiWtQBXlZJn1+mF/suRF118/XVJjorVS1dA5skUWF
	 bavkp+QWvmbkGc9B3yxQPDjwiK3BU9PA3kwzb7sn4cRjbcaXpywEflMRtmo478Uxs
	 7nVIRHPbeu41+vz/UpVMFkpyPexDhQcSdBYLtjjm7e2ZYmKg09qDmdujx57+d/c/h
	 MRxaJli4vCg3qmYVGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmhjw-1wlpCT2JxW-00g5Im; Sat, 14
 Nov 2026 18:08:15 +0100
Message-ID: <368d548f-2b86-4da5-857a-6ee9473a8d0e@web.de>
Date: Sat, 14 Nov 2026 18:08:10 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-sunxi@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Michal Piekos <michal.piekos@mmpsystems.pl>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Samuel Holland <samuel@sholland.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] iio: adc: sun20i-gpadc: Use
 devm_reset_control_get_exclusive_deasserted() in sun20i_gpadc_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bcYrRsvnGUvDnLhR2aHquCfqUIhSnm4KsuVI70erQkRw8AKN1rd
 r0WxDX6KcDstAuSsybpXja6JkAJqDWT1VdMpq0q79JmuFW3QKEA/qIK0mZVQ+PE+IKhZXwP
 MG+4xLyFL37o5QsqeMBvxm3DE8uQhOZeEklKKOY6Y2nSwCNMVfBbmwMAkKCRarSvs1tk2RB
 z28NS0r/aOgrtEPsS2huQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bIMu+I8cahU=;eR6mIJz7+FgcsTVGNiy6pRkrB7s
 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
 tMffsMxb0nW242k3Pg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Nov 2026 17:55:16 +0100

Use devm_reset_control_get_exclusive_deasserted() to replace the
explicit reset acquisition, deassertion, and cleanup action registered
with devm_add_action_or_reset().
Simplify reset handling and remove the custom reset assertion callback
while preserving reset assertion during cleanup.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/iio/adc/sun20i-gpadc-iio.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-g=
padc-iio.c
index baa7661db13b..070d061572c6 100644
=2D-- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -157,13 +157,6 @@ static const struct iio_info sun20i_gpadc_iio_info =
=3D {
 	.fwnode_xlate =3D sun20i_gpadc_fwnode_xlate,
 };
=20
-static void sun20i_gpadc_reset_assert(void *data)
-{
-	struct reset_control *rst =3D data;
-
-	reset_control_assert(rst);
-}
-
 static const struct iio_chan_spec sun20i_gpadc_chan_template =3D {
 	.type =3D IIO_VOLTAGE,
 	.indexed =3D 1,
@@ -225,17 +218,10 @@ static int sun20i_gpadc_probe(struct platform_device=
 *pdev)
 	if (ret =3D=3D 0)
 		return dev_err_probe(dev, -ENODEV, "needs at least one clocks\n");
=20
-	rst =3D devm_reset_control_get_exclusive(dev, NULL);
+	rst =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rst))
-		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n"=
);
-
-	ret =3D reset_control_deassert(rst);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to deassert reset\n");
-
-	ret =3D devm_add_action_or_reset(dev, sun20i_gpadc_reset_assert, rst);
-	if (ret)
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "failed to get and deassert reset\n");
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0)
=2D-=20
2.56.0

