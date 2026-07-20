Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796701FD4
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784507093; cv=none; b=kKrB1HXLhONsq7iF2w4kIs2q5Gv2uGI26PrnJwXiU8bTLizIMoYk/F8exM/Q9ICY4S/Syo75/USF0Mt1pT3IhLW5u2bdMZlHoF+tNnuAacWcLpupnF6xoG8KypH7GIyycjddsEUINt5bjwg5S9Ua18eboCb8225XONBx9BowC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784507093; c=relaxed/simple;
	bh=rWZgX+3IhxCOiJNwkoi97BeMY2af78nazBszpyqOFVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6Sfzs6Be1G66lnjU7O5+uhS92yPlMUpdGgvYd4v5HJPcGiXXipEevhVYocgyqNSOXMjNeQBAQNSJFBORrHMC3PjynSvaBhWIHZ4iSUJZpQSaF6zzLhO/lQiu6KoyBo6jIJCrUQ+YX/0GBHFCmUNssn8WVWfrVm/HN5YNgdDszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZhUzwZf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ge40mAfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZhUzwZf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ge40mAfI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt2n9646196
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DIBLKaAjsvT+adfa2mlFG271LGLD0bnzyRQnS0cq8V0=; b=IZhUzwZfYExfUHWD
	3QgubwCJslvhUEfoECQDLzr01328Em+Nj5avgoi4O8eVf0dU7G2M7hmkyzVlncHM
	KJKJqmbSzTMBhw59Ja5MSC4HlUzwAwv2mbtuzb6hBU8Yv0KXx2aCFWxnlsuoxpAZ
	WwC85xsnolyBY6qPTYE8xCFiTbyo/2ajrI02tua1IwzBrLZrAuPY1swczNHFiz2S
	7BueHkgRdgBcJhWcRIFWR921/pCsk0yxCkXMj3k3DXKNc7KWQ8dzFvCRJ4m+W7Ox
	IR9Lf1V3GR8EdwJMcj9i/EORG6ZoQ1b9TiilSFbBFIIe6jWoMvFpVygX1Rz7Jl5h
	IUl7hw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvurjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:24:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b13so83319a12.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784507091; x=1785111891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIBLKaAjsvT+adfa2mlFG271LGLD0bnzyRQnS0cq8V0=;
        b=Ge40mAfIZhSZThNIyTev6dkFN54q6SbtWYkrd0o2Sb19pnyfNWJv+2r6YLHUBTDWlr
         r5Vcpl6McTEzYYaUMvkl4IRxuLbLJKT6o1gL+qd0PwbXIIP5avw33Rr0Hoh6+Hs7lxPj
         rgExXkYM8zYA/zNtex6ztQYENiQ5M9v+oyohjRFHI7bFQmcke6kSuwDsIpogFOqk1tD6
         F0fi0wjRB2zp2nSUHssEO1TM8OTF55a10hcSho3TQru2QK1LrEcv/19VUyZuJKT5461A
         ZdwvnwDTfq0LJq1CvddwiXZlRQfrFRqlFxDamsJFDafguLB/mFOsZzAkmVKDZQU8YgFt
         /vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784507091; x=1785111891;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIBLKaAjsvT+adfa2mlFG271LGLD0bnzyRQnS0cq8V0=;
        b=cxYb74epZNtFfCGzsrDMGocwHLL4/mmesEZ93sXS95JtCKxknrF4HN6yLy0zcw7fLV
         Esf2jOkA5nvb+Id6L3hCAColdomrmUIQeESdO50UH1oEHWnrlYPSqu5sxA3kRV+NQNLk
         2Bvf7fzZPySmTYsTWZAUCXuOrAG7JoEIrmB8H0Y/jvuaxny294yulsWKht3rESGlOWSk
         pa7YMXdYVtr2V47iYC6oWb6dwiQ5hrzgDISJvGWIpDdFKf4Rx+OHZ66jp6Nyll337r0Z
         e08MNRN20oaY/VybLtlxF1G+RwKc+eva0wytq5jQB/ICO0PErIxoTqm+wmaXv/8/FyVE
         WJOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjyJOe2SVGdpDGFfH0uEOg6/dqCGZaiBTlsKKXK5FeaSulY70QExb5RMYqLdETPuwM3KaR+y/IgI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbMe2bUMrAjEk6HSHivQ49JKZ7pgoHYGDYgjd5xRRK+sj8ym6
	YxzHuefjjWdBKhi4rtXvXXmfXQHhkOOuDR/4msiqw1MbHxqojveUZbDrPkfk5BYLxjqbeLhVkbo
	FvcpKCnGuwRhDeRsxZ+1IXUJhlHpFVzHKkaNfwOF4Vi3C44C0V4TQZgyUMK3Yt/M=
X-Gm-Gg: AfdE7cmhKow9TKMffuQMgVEx5F9AB6HM0whQ6QIkaxcL0llyJfVXQ3TYBIjILAWqiyH
	Hw4jXi5XGI2PfX9hkunEcNcCnB+6nzCQHc9/J8Y/XTFSFUfWoVlR8qV90k0k65UIoZvfgDmlBUq
	wHxaGO5HDsAT4apQmSrV/9z8Z0k5Xp2ErxT6FVOl+gvXFQb2CRqfwVF9P/o2M4YPNG4gaJzXtRE
	c/i4ThbTaqe3DK+2n783vzYkZBliQbgJu9Wo5H8KwbuxVBfd7unJBXymyg1GJ7i1FJh65tzxAPN
	4PpLH9rkCGSi0zuP7d32KQBoHqZ87C+1NAnPA6cxe3fUMFyrvtTTpgfYu1ig/4Kg/oVmjq6tuRA
	/PvNb85eyxyGJMgxV
X-Received: by 2002:a05:6a00:23c3:b0:848:44c5:f801 with SMTP id d2e1a72fcca58-84c292c90bdmr12347214b3a.33.1784507090888;
        Sun, 19 Jul 2026 17:24:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:23c3:b0:848:44c5:f801 with SMTP id d2e1a72fcca58-84c292c90bdmr12347190b3a.33.1784507090492;
        Sun, 19 Jul 2026 17:24:50 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc7adasm4805435b3a.19.2026.07.19.17.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 17:24:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 01:24:46 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
        Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
        Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ti-ads112c14: add debugfs register access
Message-ID: <20260720012446.27f0411b@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-1-fe6e1c971288@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
	<20260714-iio-adc-ti-ads112c14-buffered-read-v1-1-fe6e1c971288@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bU_Oi5fh12-gHHC7BfJ1cRhYW7xhNI4h
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5d6ad3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=IpJZQVW2AAAA:8 a=ZvEDg-xjSyqdEvwc1YYA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwMiBTYWx0ZWRfXxUqLMiCnNw8j
 X5QRTIpagJqmi2mv9d/4NAKe6mtLkcF0EBWRrk1B2u0btsIgxsdpjz/EhaI700g2RxXMbrvepMZ
 pc5UdW8lrWkNA29ZKN6sCj5aPzTvQ+R7qQQWGNqMDRO7HuudEXE5fHO5gjMuxeaWag8gl9u7uOY
 BRp0t6JaAm5RojvGOfhNBgJ/kIG9UlAhbTbbGn0X2iDPQVcgnb9unCaDchOxWv3AsowIRdnr9Q1
 fS6lNQrgQypbJclH5J6f4Z2ER9za+s0iVf9AQsBkfoSStDu4FNtTg+ay7Uo6WuuN7oDvXB4frxY
 Wfi0An13lKEEKvzvBI76Z3S2fq/8aFpIZ35Dt8+bDSX3iQKx6SXIQ6waNG31vQSIombGMQXGvoc
 j1L2BGJGg7HYSg5TvwdUKnAo1FpJjPRsmMPbAdVK8JkPeyC4kbL8wtSN7fqUwXEQvxiIvJ3cqjI
 xrRaDl8R9rXs4jyYgag==
X-Proofpoint-ORIG-GUID: bU_Oi5fh12-gHHC7BfJ1cRhYW7xhNI4h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwMiBTYWx0ZWRfX2q0uuE8Nubr4
 zI8MZAxOze75QGGS0MUJlo66H40hX/VtTrHHGYwC22ANeDM0KyMjPYsCSi4vLFqsb4GoSUTcCV1
 JOzxuUi/sYnytfDw7JOouyQrNFVOiUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200002

On Tue, 14 Jul 2026 19:19:30 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add debugfs register access to the ads112c14 driver. This is a complex
> chip and being able to poke registers is useful for debugging and
> diagnostic/calibration purposes.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Given this one is trivial, applied.

Jonathan

> ---
>  drivers/iio/adc/ti-ads112c14.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index fef3a9c37ced..28824c81908e 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -690,6 +690,19 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ads112c14_debugfs_reg_access(struct iio_dev *indio_dev,
> +					unsigned int reg,
> +					unsigned int writeval,
> +					unsigned int *readval)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(data->regmap, reg, readval);
> +
> +	return regmap_write(data->regmap, reg, writeval);
> +}
> +
>  static int ads112c14_read_label(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan, char *label)
>  {
> @@ -736,6 +749,7 @@ static const struct iio_info ads112c14_info = {
>  	.read_avail = ads112c14_read_avail,
>  	.write_raw = ads112c14_write_raw,
>  	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
> +	.debugfs_reg_access = ads112c14_debugfs_reg_access,
>  	.read_label = ads112c14_read_label,
>  };
>  
> 

