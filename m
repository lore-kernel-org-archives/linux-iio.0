Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265B43B4BD
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142255; cv=none; b=CPlmX4xJ1U568TUprs8k291yrjcBytlKxGXsj6GUfP1cK3LMWytzosw5E7IHqCId9KuebdBfE98eDrWjaIzlZQMKumtCYaoe5V1SbPmz2E5XNUJw796i089E2zexDfpu6aEZn2fjcZZqe3FW0nqm8V+PcobAcx9fPNWOIvQZcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142255; c=relaxed/simple;
	bh=H+S6QRvGqedLE40KpwbH09MLeOp4jRWCA9/C/tV2RNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNOZ6eVgYeJ8jr+ImhnFXhMg0itdEa3ct4b0hm7+ugh4KzspIffWqDYGPz0Yl85uymc0dT4VKTxV7wV0mPuTMhy8KsAohV1DxB68ngi1LXRMUH0LJeKan+/QMbHwzecTU76HzkHTcftZIOxIonbD+tmukEkYAdUwnGDGzkwyPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=MKFFvNVU; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MKFFvNVU"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 9BL9xbiXSv0nd9Fm9xnFvj; Wed, 23 Sep 2026 05:44:13 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9Fm8xgOBCCZwg9Fm9xObGu; Wed, 23 Sep 2026 05:44:13 +0000
X-Authority-Analysis: v=2.4 cv=f4JIBPyM c=1 sm=1 tr=0 ts=6ab3672d
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=8A-kgZgV7H4LFlDSZ1UA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=k8wIUYwoqdWcXq2+0C5aEKgDwMElrhdlsI09WmfuT9Y=; b=MKFFvNVULWUi
	Asrp/9c8+Ui6BSFTdUfJwK9TPk+JVpUVmDAr3dHnoDzz2tWYKDYZqhB6adtd8yK/s/SXXMvxis3WS
	1RkQVUM68f+TjNoxCsS3Lvcr0SOcWtUn3VjBmm6v+DXDiZnMeVBu7+UNGMl/4N2zOAGq4uZjtdAiU
	YX0vDPvQ312uUQmp5jcJXnd9rqkpUQ8Fp9DFr6jVODSq95c0BgjMSHX0RzBj/510P4oE1iq6hfhc5
	dUdrdGTp7Qc46Yb3amFXAgoCvlt9/4/nGkqG6yi+Jd6+UVbA79wQlqNEqUcEysJ+32A6KFYGoRiEo
	ycpMLj+36+EYaW+r3dcHNQ==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:33808 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9Fm7-00000001xsk-48IZ;
	Wed, 23 Sep 2026 00:44:12 -0500
Message-ID: <06c50171-16b8-4f9e-9b24-61c41f1325ad@embeddedor.com>
Date: Wed, 23 Sep 2026 14:44:07 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: st_sensors: add __counted_by_ptr to struct
 st_sensor_settings
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
References: <20260922112111.1970872-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260922112111.1970872-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9Fm7-00000001xsk-48IZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:33808
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP6gSgSAP5Wr7tpZTzAMU8ageaZWPd6AG7ZZsXyTtQ0Ncz+09Ct5fFww8X1HLfygmhJ/x1jaLvroS9nqgaUihE7k3tzdzs+Glz8RqTdh14pV8xRGbS7g
 fH3p2RmF5MzGav/zQ3k3qbTB1NkKzmCrLFfH9mgwceY1iQmrqCvR8oJUSC3IrM5hiAFs5mXFGBtVPmgeGFLhxD2KZGt+9L1rCbE=



On 9/22/26 20:21, Bill Wendling wrote:
> Annotate the "ch" pointer member of "struct st_sensor_settings" with the
> "__counted_by_ptr" attribute. The elements of "ch" are counted by the
> "num_ch" member in the same struct.
> 
> All instances of "struct st_sensor_settings" are defined as "static
> const" arrays across the ST sensor core drivers. For pressure sensors,
> "num_ch" is explicitly initialized with the size of the respective
> channel array using "ARRAY_SIZE(...)" during static definition.
> 
> For accelerometer, gyroscope, and magnetometer sensors, "num_ch" is not
> explicitly initialized (and thus defaults to 0). This is because those
> drivers hardcode the channel count to "ST_SENSORS_NUMBER_ALL_CHANNELS"
> rather than using "num_ch" from the settings struct.
> 
> Since these structures are static const, both "ch" and "num_ch" are
> fully initialized at compile time and available immediately at boot
> time.  The only accesses to the "ch" field of "st_sensor_settings" occur
> when assigning it to "indio_dev->channels" during device probing.
> 
> Because "sensor_settings->ch" is never dereferenced or accessed as an
> array, adding the "__counted_by_ptr" annotation does not cause any
> runtime panics or false-positive bounds checks under KASAN or UBSAN.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/iio/common/st_sensors.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 1ba496f0fea5..6e914ed49529 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -206,7 +206,7 @@ struct st_sensor_settings {
>   	u8 wai;
>   	u8 wai_addr;
>   	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
> -	struct iio_chan_spec *ch;
> +	struct iio_chan_spec *ch __counted_by_ptr(num_ch);
>   	int num_ch;
>   	struct st_sensor_odr odr;
>   	struct st_sensor_power pw;

