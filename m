Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4E2BD59C;
	Sun, 30 Aug 2026 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788130071; cv=none; b=uYUNbXKTrn2hczfB46x9K9bV6jF00TaKIx9C8uvUTuDD8VMhaI1T/SdgsYw/nQi+L/kmtzSCCB4RwG6mXgAmeu4jw0EP9fV3NxmmE2b4aLCQ9si3a+JWPkjVmZbviYS9JudMRup31be7MjMjGBZNjLkMhmSH9CPXcInz4/4yz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788130071; c=relaxed/simple;
	bh=Ml669jWNUPB6veXivIWGPaXi4VODorGd01ePhwDYgCI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XkD687rpmz9lf3s2fO6sJUmxXlAwhI0ozzse6CJlhHgTdxz+Iktoae3kxZPtAlhOqh2dIbZ4njorXI1QnNy+q5+M1Tn4nvzBWjSQzgGe3X/i/OJz+ECDgBCxckebbdU+8SqRhkzWoqrwjeloDPoNzisqFePvBvd2aMHyQQnczSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oipy+zJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oipy+zJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF81F1F000E9;
	Sun, 30 Aug 2026 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788130070;
	bh=IlNmwGiY0W2+hm7BPL2uH+3Ld2UzHycm4agb/Ohh3c8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Oipy+zJP+3k8Tu1RTgpZx+LOJ//odyXn6BdeG3Jm+gxmfXZkS3jSEuoufaeZKVJiV
	 pd2CEOzauvpgkNyNkT2huDBYz4OgZ9vGnTRotNMnu98f6y1Vc+JWNJHjKZCm2c18aR
	 aA0bF9JDe3+SUataY6lbANM62eU+l75W6Pgv4EWmQTPvBO10WCU/jXPztJcdQhBt+J
	 HN5M9qNrCFcGL3bs/ufFbST5HZ+qs+YRbnhM3uxEeLmw6dRFlUu2dxaeyTrPqE6aWI
	 jJHPoFNEk1iKnx+J465DXSQnmi9AisaBCOn2jES1idyyssOuKHFZW8fPeyNXMLRE04
	 WG9j7lMuckS4g==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: add burnout current
 support
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
Date: Sun, 30 Aug 2026 23:47:34 +0100
Message-Id: <178813005477.2788519.8915020094810013082.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2770;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ml669jWNUPB6veXivIWGPaXi4VODorGd01ePhwDYgCI=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlLMKMZJwJ2OV5cslBIoxJ+t3ai09acclsimNX
 x0OzTFIpjqJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapSzChEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiC69D/47lfLVWZHDX4uCJoAOzFvLGY2dIKgBsSBARpCQjncYfM1
 uHGECPtIUlpkVUw7l0aUWbirH19GJiQWJE92PLZdvA96obfszo4GFHwNTN6BJrsJ6AQL7TlNeQX
 NRoDMFcfRpECEjgbEhG9gqY7lXRmRbAdn17IPke50HWFI6vcK4wkTN7DTnHQS0BBQ+AeMDZiZmh
 llqCIydRjD4Yd1NYl1U+ZJsHT5wJLfh/GOSUFF/PGtY4gaQbKCcRU/ySsVdAKygbV4aV9miz8GM
 b0BVjSmKL7FDopVjQiCoCMxZhYVEgqeb9A9KXIQOanBmyT7nVZtTuBap2KJoHSABrrNaL7BzEGL
 ZDKOiGaT87/KuDXOSR7SU3Ro2OQ5C4v9phdBBPhIly9Rqipcrpuyxv1FwVFmrgPRp93Ry18kGDK
 uv3E/5dOjD0AHXXAJ3t5IzX0MbVvD1vK1jbDN9gx1KtElRM6ETTIwX5DS/IpJKzI7haUa6d37ca
 MbRw12Ak/b9vJfHPojY3FI0syOFC3JerT1Ep+UBOrLRUEEI4EWWRnZrOzMPG2PSDHSEGn8UxQ/Q
 QwdXZD9mPkb0AXJTvOjWyQ4Gp22GiTpvWYEOR5Dkahkc2b2AP/u7KPgOCs8CmpdeV631eI24xLq
 qJcr+wewHLAbxIH/QUQWf3ZCaO+dutCCCcj3i6Q==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add a custom attribute via ext_info when a channel has a burnout current
> specified in the devicetree. This adds an in_{voltageY,resistanceY,
> voltageY-voltageX}_burnoutraw sysfs attribute for the channel that
> performs a single conversion (same as _raw attribute) except that it
> enables the burnout current. The chip also has a restriction that input
> chopping cannot be enabled when burnout current is enabled, so we also
> disable input chopping when burnout current is active.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

Hi David,

A few trivial things inline.

Thanks,

Jonathan
>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 878764deffc5..58c815f5faeb 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -76,6 +76,11 @@
>  #define   ADS112C14_DEVICE_CFG_PWDN			BIT(7)
>  #define   ADS112C14_DEVICE_CFG_STBY_MODE		BIT(6)
>  #define   ADS112C14_DEVICE_CFG_BOCS			GENMASK(5, 4)
> +#define     ADS112C14_DEVICE_CFG_BOCS_DISABLED		  0
> +#define     ADS112C14_DEVICE_CFG_BOCS_200_nA		  1
> +#define     ADS112C14_DEVICE_CFG_BOCS_1_uA		  2
> +#define     ADS112C14_DEVICE_CFG_BOCS_10_uA		  3

...


>  static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
>  {
>  	u32 current_uA = current_nA / (NANO / MICRO);
> @@ -1285,6 +1365,34 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  		measurement->global_chop = fwnode_property_read_bool(child,
>  								     "input-chopping");
>
> +		if (fwnode_property_present(child, "burn-out-current-nanoamp")) {

Andy already covered this.  I kind of fall on the side of having the
text inline for grepping when there are only 1 or two instances, but
when we reach 3 it seems like the time has come to use a local
variable.

> +			u32 burnout_nA;
> +
> +			ret = fwnode_property_read_u32(child, "burn-out-current-nanoamp",
> +						       &burnout_nA);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read burn-out-current-nanoamp property\n");
> +
> +			switch (burnout_nA) {
> +			case 200:
> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_200_nA;
> +				break;
> +			case 1000:
> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_1_uA;
> +				break;
> +			case 10000:
> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_10_uA;
> +				break;
> +			default:
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid burn-out-current-nanoamp value\n");
> +			}
> +
> +			if (measurement->burnout)

I would use an explicit match against
!= ADS112C14_DEVICE_CFG_BOCS_DISABLED
here rather than non 0.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
