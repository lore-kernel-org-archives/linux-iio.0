Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAD3264F4;
	Sun, 13 Sep 2026 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330639; cv=none; b=aWrS935YFArPj+xzW5urr+22VxoAsGcLYnuaY+vbf2x9NpYCGOe+JMQjy21Wthp+qYKuZOiU4sIlKkaBci/IL+MQyYfzsqclbwi8wWNwwXsrGLKeyNFw7FKpgmRAK2MZVjVMftQozvFQsGNwfUY9yucMGOkdbgvf+QvubvW2gJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330639; c=relaxed/simple;
	bh=pAvqG+XDOkSpj5ahAlzM2ckt8umlnDFjYSY/u/3CRSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixQ4y33a/dTFA/pSUZD92uaqLI9SmArb3rxTTFEnnI813SoCcGDqkRuejHp4Ig4H3/Y9dB/2NJSE9K6+NcfwjSsE/gI4TYoXKj3NZnq+lHHa6SSASPysjxHtHKY63JMmdnIUe6y34qEYEz47hu6TMTEOmAetTuIvbE2nQuBdVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFQKrqyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFQKrqyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C209C1F000FF;
	Sun, 13 Sep 2026 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789330637;
	bh=pL0rN0BdLe/jm33CSgSqHqvwRCkULbks7CI8aOkDdRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QFQKrqyokRwGTpB1SwoSs/poOcaaoRgok3+OP7dc/wx2yfUbFffYyH5jBpGI4QbU0
	 4cKgVRtwfc3d3uTPWH3Ezn33ENE97sVojNbzLl13QauZNSDVyfch/1Z8r8gSQRTtd1
	 3pYKaw9vX/iMeu4Z5fD8v5zHKphH9uECKUP0o06eSZ+vRUbYsqRwnPn0cjH17PKEc0
	 FLGCDwos2Pli9BA6dNzX5mcL/+at5EVHKeWkQIsE+yclODinKHlApSLYtN3g5aBQrt
	 nGg0pT9xA1oiWiAcEobF2JNKRzfZgoEuhgCZjTXqr9cu6PV8vjGZOpTl8m6jxr+m97
	 FyeiODCVXde6w==
Date: Sun, 13 Sep 2026 21:17:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iio: adc: ti-ads112c14: add filter support
Message-ID: <20260913211715.4d74da75@jic23-hlaptop>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 16:12:59 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> I was hoping to avoid this, but until [0] lands, sashiko doesn't know
> how to handle patch series with dependencies. So I have combined my
> three outstanding ti-ads112c14 series into a single one. It's really
> too much all at once, but this seems the best way to speed up the review
> process at the moment.
> 
> [0]: https://github.com/sashiko-dev/sashiko/pull/389
> 
Whole lot applied to the testing branch of iio.git with:
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 0e4584b4675e..3730e5539310 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -181,7 +181,7 @@ static const u32 ads112c14_pga_gains_x10[] = {
        200, 320, 500, 640, 1000, 1280, 2000, 2560,     /* 8 - 15 */
 };
 
-#define ADS112C14_INTERNAL_CLK_Hz 4096000
+#define ADS112C14_INTERNAL_CLK_Hz (4096 * HZ_PER_KHZ)
 
 #define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
 DECLARE_CRC8_TABLE(ads112c14_crc8_table);

for the thing Joshua and Andy both chipped in on.

Rest looked good to me.

Jonathan
