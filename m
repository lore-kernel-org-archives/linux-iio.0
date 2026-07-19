Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11728C2BF
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784502494; cv=none; b=MGocc7WDBRftKpxRYHcoWY6nsmKPNn50+cFc/0N5iB4WDDVgoFo6nOHEF6MHYMUeyYMD/Nx83Vy1Ub1YMyi/IN/nAIP/dujyAYptRtUgPbX3WgNavxtHTP40AHB1Cp7frKAjG+roxPLWy8C6mFHW8LDtlEOaxpikRd1furp5QVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784502494; c=relaxed/simple;
	bh=TBzIujEI5cVMShYnP0cIJc6bOwUwC0Ol7KBsn9W1f24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crMp9kf6GGFs5b0EQ63fbj6N8J+1PesoF1rTxdtHfwsVIEhunr+qO/amz2M9eGkOtgtHQdA9fQ6eX/eNfiOo9jzzbmez6ty1aVksZ5s63u/CfYuEagB5JhZQCEHKInbSFJGyqSEGsZdXV1dB4gMDyMb+yqI24ATl7QlFZpCnHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=peIEerk4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJkY0tXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="peIEerk4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJkY0tXF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQgwo220214
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7lEhViJTqWmDXZiB6V/knCwrtAyVIbdBJvhBeySb/5g=; b=peIEerk4WEn8qK3F
	XBqoZdd1yBOPB8SvJGhZ5P7ktzpkXO0WAPkxg07SVi6aOIQW1w9Ek/w7cIvUtSvZ
	s73BdK2LMVgAm8hcodE82mrDGLnxhyAX46BX097dizwQ9Gfk1rJwlT+BGNmp1jNE
	j6SRNk1wtGO7ozM/qF/J+6y2FhRFEPI8J6rCrK2V0fY/WAa/Cjk+XhfOm9VwZn1r
	ntlPaHGd+ARl22vu1ds9JCEUX6Ud4vJytJ0DWBTDO7cSJesB+zGaWwzFjfcdyIS8
	WYBQR+9jnwCLS5MKz9yRjNWKy24cBI/T3LswT4Hg7VKoJQolCGw/QQHiVnIMTqoq
	aXKVXw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvun32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:08:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so7567862b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784502491; x=1785107291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lEhViJTqWmDXZiB6V/knCwrtAyVIbdBJvhBeySb/5g=;
        b=AJkY0tXF1faZCmBgf511Sp//rN+XlAyNbw+elIukOl/EqxWRBYFWT94ZSx9D/LJzDe
         0keugqVIWDhpX3JUbQjtmHfPANTUycgFmRISAeGVRb3nen4ZM3IIE1xmO16bFIPA3eWy
         m//iZip45oSueAuJshwRAEPtUOq+YIH+1BJG1WCtEGJJbqL7Qc0bxFeZh2y1EGEBSZWj
         q9ZuzRmjZglkuKKnFA/IolkqYJjIn4L9gOU/str9ddLNW1f0QdrZIjDvB4diAhCS3+hj
         660AlmPQD0jlIs+7hESl6Cowe+GM4ECi58nD7aQxvEp7nUlXwCBU0ttd4xMChZ0wGSr7
         CMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784502491; x=1785107291;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lEhViJTqWmDXZiB6V/knCwrtAyVIbdBJvhBeySb/5g=;
        b=T3g131CHwsJTx1kBQPAxhojh0Ynztz0Va39cKaTg0ZOqI8y3ELuj+xDw/8LzxR9sJ6
         DJNTPVVh7isl7DhHPx69qkVpYcpgKzOvlpr9FlONRrvRAX/qB0c78Djg1xi7CtUGbcGC
         yc2lMB5GzGrmiFCGz+2R4KJD7ZIeO+jWjOCNgEPmTzLV5WZ2aPyqyEGyOTIMPCyn1vyj
         CCjfUvz8a5z8KtqS0igs+/OtNXzQVTyVfBEusfFczfGE39u1n1fhMHSfX+ax+6FWgO6T
         NIk4OBMj0ePxnYWtDc97gJLF15IVFIloxgWwpQbgHhnQ+2/jm2Zc1oUyfbvXLndDjq1k
         KcMA==
X-Forwarded-Encrypted: i=1; AHgh+RqEDpK/qCtlH70umAWF/YXNGzmo1Nv1sPaSTD58VEV1BGh7svA1+l+fy8fIoM/YaRvfK5fjp51SYxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykWxA6l3Fc74I28rYEueCcCNikNMUTlhrJyp8mRjtdrjxK/QcW
	k39YcYEbAhwXbbTJMplQkCI1K2JrHqaFecNGNYtYvz/fKGGTBqWKQFJniCfE5CCH9QO0PdyU/zg
	3GLCTrxFB3ofXBCxSBSAqjnN9GzIEHlgMPOvQFq1tPe58Vc5MjqsLTpcNLhNKyGU=
X-Gm-Gg: AfdE7ckpS1PhbX2IZk1EFnxwsnziWlT2vtWmQdZwweyptwz3H3XHX72o5PiiHQgxw4Q
	tQbxxo7NHwdNAPOMad7tVrgYqHxJmofDwdjlpgU+k1qK0T1BKsAeaCBHdltxls2AcHtuda5KwMo
	706NqCRkZbADVt0jS7HsDczSVecwTkmFkbN2oAedIMatVdwtDVi7M3+9uwPkB5n1kdBssxeXS4G
	SWcS/mISC7Qjdq9WqeQfyInFVHRQGs+42s3ZqNkUqM9rYFYUjo+tHRkqcXCqWf42lXdsivT/9Uj
	VK2v4kbP5KFN53UjMG8hgEmBcRhM0awoEOTdKVpO4DxEVm0LyS7xESYpVwvAv5R29BEuBmeSlpc
	uANwjcb1+am6jhM6F
X-Received: by 2002:a05:6a00:1826:b0:848:7997:cb23 with SMTP id d2e1a72fcca58-84c2945cda5mr11120746b3a.43.1784502491389;
        Sun, 19 Jul 2026 16:08:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:1826:b0:848:7997:cb23 with SMTP id d2e1a72fcca58-84c2945cda5mr11120723b3a.43.1784502490890;
        Sun, 19 Jul 2026 16:08:10 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb6c2sm3616207a12.21.2026.07.19.16.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 16:08:10 -0700 (PDT)
Date: Mon, 20 Jul 2026 00:08:05 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>,
        Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>,
        Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] iio: adc: add ti-ads112c14 driver
Message-ID: <20260720000805.41022604@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-6-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
	<20260714-iio-adc-ti-ads122c14-v4-6-25f8e3084485@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nVI1hVibe7IrPIhjk7tIxZQL8f2JnUFK
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5d58dc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=IpJZQVW2AAAA:8 a=FPNj1WgbcA2tj7y3evEA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI1OSBTYWx0ZWRfX4PrPnZyDi/gD
 Bk3Gx5JFTtFbJ5OGJeRvPkUbpZ16gSTjViqBzeRfXud3msdu3WK4xODqGU+qUqk9l1pOAs+Ob2D
 63Kj+V5PMXuZF8EImBcOsdklYheGWbDZ34yp5je/ZL5ZMai/pFKa4kdhp/msUgmPZcxmFLdnT0U
 yxRCDC9sb7SeGknPIMe9rHcFTb8GFabHdI7t0tP8kKLCjI9OE/0zYb+Wkyj0kn5ZLUD82/yqTOZ
 IUVpfBTazMNDMmZbPORd/qzhH1GGuM2AAPwGBqSBZGJe9ObJlzsKn7zHLan2pzKvRrs+otz6r1l
 +DHsyrBazKc3X1Cs1A9N3/2KmKIi4C2mfjzvOBfFhYLXhle2Y28lqra6ZpQv1gIrenilzu9MPb4
 DVrAim0MX3TBrgdJf3eR8CUYzoElIo425bC0QCTUNZAPvqri6Xi5+kSykoQDWNf5AgtTqvsaqEB
 NhauGok/FAnoNj3VKlg==
X-Proofpoint-ORIG-GUID: nVI1hVibe7IrPIhjk7tIxZQL8f2JnUFK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI1OSBTYWx0ZWRfXzAXpyCQzhdbZ
 uXXvNtIjfx+aje6boOFxEuyhQAgy6oS91yHd7SiIqBOaXwtR+jqM6Fi8Fex7eaV5SrYz3+zxgui
 3q6+h6MKk+XpBK1KQkqE+My5/IBdTD0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190259

On Tue, 14 Jul 2026 18:21:28 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
> 
> This first step is adding a very basic driver that only supports power
> on/reset and reading the system monitor channels.
> 
> ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
> logical order by address to keep the voltage channels together and in
> case we find we need to add variants of this channel with different
> voltage reference later.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
I think sashiko is sending us on a wild goose chase on this one.

"When ads112c14_single_conversion() calls i2c_smbus_read_i2c_block_data(), it
returns the number of bytes read upon success. A short read (e.g. 1 or 2 bytes)
would return a positive value, bypassing the (ret < 0) error check in
ads112c14_read_raw()."

An i2c_smbus_read_i2c_block_data() response doesn't contain a length
unlike i2c_smbus_read_block_data() which does. 

Maybe there is a controller driver out there that messes with block[0]
rather than returning an error on failure to do the read part of
the sequence. I checked a few and didn't find one.

It might make sense to make it clear this doesn't happen by
adding checks in the i2c core.  One to consider after the other
ones on my list!

However, one small related comment inline about keeping postive
return values meaning success as local as possible in the code!

Jonathan




> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> new file mode 100644
> index 000000000000..a69c595ab518
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c14.c

...

> +
> +static int ads112c14_single_conversion(struct ads112c14_data *data,
> +				       const struct iio_chan_spec *chan,
> +				       u8 *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
> +	u32 reg_val;
> +	int ret;
> +
> +	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
> +		/* Not implemented yet. */
> +		return -EINVAL;
> +	} else {
> +		ret = ads112c14_prepare_sys_mon_channel(data, chan);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_START);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(data->regmap,
> +				       ADS112C14_REG_STATUS_MSB, reg_val,
> +				       FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
> +				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	return i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
> +					     BITS_TO_BYTES(data->chip_info->resolution_bits),
> +					     buf);
With all that stuff above about this not returning short, I'd still be tempted to do
an if (ret < 0) return ret; return 0; sequence in here so we don't propogate
confusing positive returns beyond where we can see their source.

Having done that make the outer check if (ret) 


> +}
