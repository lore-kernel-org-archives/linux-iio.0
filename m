Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100B1A6815
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335336; cv=none; b=IW3scJHEIe7OZ90MqWItQ9NTyCkcxYsLIkThttAB1bnuUvY1Na+Qkjpg1zzCVY3e6b3v3l87rXmTelAF2MARb3Q6nOXvIRvsPd07n1QQKzCVO58H0n8dgxsl6eNYac2j9sIa92oW2/6Rsa2Q8tTDcYOX+ESl+gAcoe0aQ4+h8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335336; c=relaxed/simple;
	bh=x9jIjVo+eJcNHwHswz6GgzkOKjKzkKkwNX1aixLbfEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5iWJj/H9BovqmED3GLBkepXVY3ua/whFnu4t10RKOdRhm4u/f+OdbXehRXorMQn6O9xYFFdAvF18gJ2p1hPIT5KZ08otkdmSb0Qi36RcDtx8GnlGG2iiB6Qxoyb94TrBNB5Aui5hWvcBWuXX3YYmWBkmB0sfrdfdkoO35wYGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxN/c6V5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V3/izAZA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxN/c6V5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V3/izAZA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNEPhx3312533
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VYNDZEsTRkx8C8pLWiaNTIIUj7clLRb9FvGM6FnccrA=; b=nxN/c6V51Vo984hm
	AyfGaaFDqimB3RSaNYAQPETcROCdGPq8WdoBiPxDmkzk9BZrHuptDUW6fPOGy6oc
	QHPGcOf+N1TpvuM0JeETZjm3U1AavrRDFWvADDL2Hk43LPuoRLvWVInBHhKv8BQp
	1dUAAyJgrEuujmVLGkRd7d8elaswjBSH9OxyHOdNB0XJA0GC/4EyIkdew8r8gycg
	FP0KDwp1upZYIUejUxX5hx89kq/b48fwb27JPfPZT5AbaaSQuD3NQEyvgt2JJpaw
	D8tVmxxsGpJ/lWTASEAN+mzUEctuAYIlatBPOEUJ94k0iQ7gIf1Esw3UUK/6Q4Rm
	3xmRAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfk6tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:42:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so36144755ad.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784335332; x=1784940132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VYNDZEsTRkx8C8pLWiaNTIIUj7clLRb9FvGM6FnccrA=;
        b=V3/izAZAh6ul0puc69YPOJvItGojfvD1ccDFNRi/IwMi9wXrQ+dWkaV0XWpNChEY/N
         rfiSIpWI7I+ke2wcRlL/i8UY4UkTPy5IJMoIxATlXdQf7FKczYmwh6eWhOJG2SSPBPJD
         65gyDRBCMVtK0/w9H27YLS2et0LWAlG/IxeA4w4a2A2Ap0xy5zkHWCZjAcg8HmnaGIKt
         DYgZqsJlZBujAeqTJGFFWyjeMhUDc9lrKOM5nUWMzbE2nDs45WkKkjhttLNJssGH2Jr2
         CtAKqzg18rhrDak9ZnVaR9/lPHzpPRLCPFda4CKdgxWcSiakLK7vBWkhegGxB6jNqDfX
         spQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784335332; x=1784940132;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VYNDZEsTRkx8C8pLWiaNTIIUj7clLRb9FvGM6FnccrA=;
        b=eN/kPF0z+6N/tdfAJnkaeDwFnMNcN1JQYVqxKNJV+XlwqPN5pZxn8MxRlk1Dthu1ph
         bSS1YFEhDY6uLBrkRLwGw897UGzww8K/Aj+rxgQhBhfUj7pOt89+rL+lCw2NVkmw+IfW
         cfGSRi+Ki8v+8V3y2+CsaR6XUMs2taxS/KCw9CFhHZ/YCiVryXFYemZLU9eWNir5lFPD
         6nv612LAYm+0TwSt0i4QMR0gkiAJ1tXncYDXZaVWpZQ091romMd0RXqfzaVsbL5digbM
         K8Z8CXCr2scC01OR9mjJn9uFi45ev9Duj2kEy2m5M69Cow1DBPAl+EgG/sIbz3Yr3oFU
         1GJg==
X-Gm-Message-State: AOJu0Yw0GT+1XY2c48eO2cHKvVIxZFym0CIefBBUUkjAb8yzRinqEKBn
	ZNBiYzKfdY+W+rKQDoct2OGl24V82zK4BoxSPnM48gQ3Q/P3eZ/o2BBOtVdTZnuoK1v2zdWnjku
	ghIl6h85a+pWqI5qOot0GMt0JZ3ZiikRqe3dMFxlHt2MR+LlfzrgSwfkLJdJAkjY=
X-Gm-Gg: AfdE7clzSzJ/FcB5oFFn67PCL7tPbyUWd9wFzpLvdm9DNyQubcfDOO+FBQfeYzq6FxE
	wtLfAaUS+2JwqPfm5nCyK9gh/i2OurMb/B5rCZn4yVl8vWvaXBOd/w5gHtpMknFbrEtkQ4STy9S
	9zPZHv2ekUQtkzgPHMIgEl7qumnR+7gxnS3jHdSREunnsPmMjYgMybBoSnS3HNxt2KlgeQp3bKk
	WUHGFcU0NDAmwfTPcerekl3UJob8Na+L1s/G6Ax6V64/99GdTWDkDb3x6Wu4zYLBgZDHqs4xTwV
	nQNAvtVvPaOlb+yWbCc33C0Amj7S9BH6uip1fTFl9JB4IUaWYpwAgYJH8bncvfXGghnj2EIqGVN
	KmeehVZU+zg/d8ywz
X-Received: by 2002:a17:903:2b0f:b0:2cc:841d:cd7e with SMTP id d9443c01a7336-2cf34a41636mr49752525ad.21.1784335331888;
        Fri, 17 Jul 2026 17:42:11 -0700 (PDT)
X-Received: by 2002:a17:903:2b0f:b0:2cc:841d:cd7e with SMTP id d9443c01a7336-2cf34a41636mr49752245ad.21.1784335331326;
        Fri, 17 Jul 2026 17:42:11 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da144sm19019325ad.38.2026.07.17.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 17:42:10 -0700 (PDT)
Date: Sat, 18 Jul 2026 01:42:07 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <nuno.sa@analog.com>, <devicetree@vger.kernel.org>,
        Ciprian Hegbeli
 <ciprian.hegbeli@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260718014153.03d45981@jic23-huawei>
In-Reply-To: <20260717123852.1140893-3-stefan.popa@analog.com>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
	<20260717123852.1140893-3-stefan.popa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAwMyBTYWx0ZWRfXwzGS516qbidV
 nsqa7+LzISFI7QHa0U1bEqKxF8QSW2zRaZFlG3Q8Y/qq+BUvdo8zlEs6HQEk2HYAcYlOBglb612
 Kzz8eScRPSMubFzTH3ImOLjLIxh3cxjfZTivE2V8ZGkLEs/ZP6bacwb3WD6D54LSTaSCi0H4xJa
 TcDtb4dxd8NTpxhQ2M3zKDYe8XN8DdfuRKsOUOswcd7Sqw7FBE9ElG0GvriGQfEhF1OsH9TvC39
 GZGg98DdnWvB7sIYOYsbISlUDc56ft6BQiQLzv1IENO9wqclRnVywt5+ITxaHtTiCvhu37wH4bZ
 HHJE8qMWxppMDmlPX+uC+rkrKgdB/FmFHLrm6UsmcYQu/4dKPg48M2cL9SFTjsX9pHmFm69p24l
 mlEEb+ZEfZsjbeEkeaEyoGGDXp6KOAKc0ccIxd78mWafD9Lh8p/zMXR90YChZjiBT5KNcdQQz+h
 yEH3h+yVIejXoggAirA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAwMyBTYWx0ZWRfX5b8fuIx4ti5N
 B21v/qBEOsOGIRQp2Da/UqcoylHdiRZPYt+g1CykZEISP6LYOz2wrRvCwD5xACCwjVAfCC9d0GX
 KCsXhL0GIOOeRuiYtKJXY3+ToYRFKdY=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5acbe5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gAnH3GRIAAAA:8 a=q6Us9oxU5_cphkN4qwoA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: JQTkz8haAL4YRW8HwO2IwI32tqkK-Wcu
X-Proofpoint-ORIG-GUID: JQTkz8haAL4YRW8HwO2IwI32tqkK-Wcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180003

On Fri, 17 Jul 2026 15:38:49 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> No existing IIO driver covers this device or a register-compatible part.
> The closest relatives target different silicon with incompatible register
> maps and feature sets: max9611 is a unidirectional high-side sensor with a
> die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> max34408 is an 8-bit multi-channel current monitor. The MAX40080 has a
> device-specific register map with bidirectional 13-bit current, a 64-entry
> FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Command,
> and two selectable input ranges, so it warrants its own driver.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw and scale attributes, a configurable oversampling (digital
> averaging) ratio, and PEC-protected register access. The two selectable
> current-sense ranges are exposed through scale/scale_available; the
> current scale is derived from the shunt-resistor-micro-ohms device-tree
> property.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX40080.pdf
> Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

For the sashiko feedback about *iv not being initialised if it exits
on first loop.  I'd just set tmp to 0 before calling the polling function.

The other one is a race even with locking as the reader either gets the before
value or the after one, so up to you if you add the suggested lock.


A few other things inline

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> new file mode 100644
> index 0000000000000..9ffb4e9a009c1
> --- /dev/null
> +++ b/drivers/iio/adc/max40080.c

> +struct max40080_state {
> +	struct i2c_client *client;
> +	/* Serializes read-modify-write access to the CFG register. */
> +	struct mutex lock;
> +	u32 shunt_resistor_uOhm;
> +	/*
> +	 * Cached configuration, also used to restore the device on resume after
> +	 * a suspend that may have cut its power: the selected RANGE index and
> +	 * the oversampling ratio.
> +	 */
> +	unsigned int range;
> +	int oversampling_ratio;
> +	/*
> +	 * Precomputed current scale (mA per code) for each RANGE setting, as
> +	 * {integer, nano} pairs for IIO_VAL_INT_PLUS_NANO. The range is
> +	 * selected by writing the corresponding scale.
> +	 */
> +	int current_scale[ARRAY_SIZE(max40080_csa_gain)][2];
> +	/* DMA-safe buffer for i2c_smbus_read_i2c_block_data(). */
> +	u8 buf[4] ____cacheline_aligned;

Already came up so see that discussion.  I don't mind that much if you
use __align(ARCH_DMA_MINALIGN) rather than the IIO one because this doesn't
need the 8 byte enforcement.  However, it's an __le32 so better to give
it that type and cast if you need to for the i2c calls.  Can then use the
aligned converters (which are probably a noop on every system you care about!)
 
> +};
> +
> +static const int max40080_oversampling_avail[] = { 1, 8, 16, 32, 64, 128 };
> +
> +static int __max40080_update_bits(struct max40080_state *st, u8 reg,
> +				  u16 mask, u16 val)

The __ is I guess to indicate that the lock should be held? There are other
functions that have that characteristic but don't have __ prefix so not
sure I'd bother.

> +{
> +	int tmp;
> +
> +	tmp = i2c_smbus_read_word_data(st->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp = (tmp & ~mask) | (val & mask);
> +
> +	return i2c_smbus_write_word_data(st->client, reg, tmp);
> +}
> +
> +/*
> + * A single measurement holds the matched current/voltage pair in one 32-bit
> + * word (MAX40080_REG_IV). Reading all four bytes in one transaction returns
> + * both from the same conversion; reading the separate current (0x0C) and
> + * voltage (0x0E) registers would decorrelate the two channels.
> + *
> + * Unlike the word accesses used elsewhere, this is a plain I2C block read: the
> + * SMBus layer does not append or verify a PEC byte for it even when PEC is
> + * otherwise enabled for the device, so this transfer is not PEC protected.
> + */

This correlated pair thing is a pretty strong reason to add buffered support
which could ensure userspace gets a pair that match.


> +
> +/*
> + * The FILTER field selects digital averaging of N consecutive conversions
> + * (no averaging, 8, 16, 32, 64 or 128), which maps directly to the IIO
> + * oversampling ratio. Averaging reduces the effective output data rate by the
> + * same factor; the conversion rate itself is set by the separate ADC_RATE
> + * field.
> + */
> +static int max40080_get_oversampling_ratio(struct max40080_state *st, int *val)
> +{
> +	u8 filter;
> +	int tmp;
> +
> +	tmp = i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	filter = FIELD_GET(MAX40080_CFG_FILTER_MSK, tmp);
> +	if (filter >= ARRAY_SIZE(max40080_oversampling_avail))
> +		return -EIO;

Why get this rather than returning the cached value of the oversampling_ratio
directly?

> +
> +	*val = max40080_oversampling_avail[filter];
> +
> +	return 0;
> +}



> +static int max40080_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max40080_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	/*
> +	 * The device powers up with PEC enabled (CFG POR = 0x0060) and rejects
> +	 * unprotected transactions, so PEC support is mandatory, along with word
> +	 * access, the I2C block read used for the current/voltage pair, and the
> +	 * Quick Command used to trigger a conversion.
> +	 */
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_QUICK |
> +				     I2C_FUNC_SMBUS_PEC))
> +		return -EOPNOTSUPP;
> +
> +	client->flags |= I2C_CLIENT_PEC;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	{

I'm not keen on the scope being added here just so you can declare
at the top of it.  Just declare propname at the top of the function
and assign it here.


> +		const char *propname = "shunt-resistor-micro-ohms";
> +
> +		if (device_property_present(dev, propname)) {
> +			ret = device_property_read_u32(dev, propname,
> +						       &st->shunt_resistor_uOhm);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "can't read %s\n", propname);
> +			if (!st->shunt_resistor_uOhm)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "%s must be non-zero\n", propname);
> +		} else {
> +			st->shunt_resistor_uOhm = 1 * MICRO;

This default isn't in the dt-binding. I'm not sure why this value makes sense.
If there is a reason the default is useful to have, then I'd expect a specification
reference in a comment to justify it.

> +		}
> +	}
> +
> +	max40080_calc_current_scale(st);
> +
> +	/* Defaults: 50 mV range (index 0), no averaging. */
> +	st->range = 0;
> +	st->oversampling_ratio = 1;
> +
> +	indio_dev->name = "max40080";
> +	indio_dev->info = &max40080_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max40080_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max40080_channels);
> +
> +	ret = max40080_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int max40080_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct max40080_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * A suspend may have cut power to the device, resetting it to its
> +	 * power-on defaults. Reprogram it from the cached configuration.

Papering over suspend disabling power seems wrong to me.
Note that for IIO we've always allowed drivers without suspend support
because it many industrial platforms it is completely irrelevant.

If we want the driver to support that let use opt in completely and do
the supply regulator disable / enable.  I.e. Let's take control
of the potential sequence.  I'm going to guess that this was responding
to sashiko feedback rather than a human reviewer?

Anyone else have a strong feeling on what we should do in these circumstances?

> +	 */
> +	return max40080_init(st);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(max40080_pm_ops, NULL, max40080_resume);

