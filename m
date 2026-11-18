Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016562;
	b=hf3dO2HsDqc6uMc7eR4tl6dE5RuLneFXWLnh/VTMa0gECpwLOFBx7M7SXd2f34YLd9Lb
	 +I4y6uWP8MXS4hCIanzkWi7nGzOo4NbH82+uFOtaFJ2WbmQPguTeQjOYdai8Eh6ac5eqN
	 joO87ZrvnRZ3OYPSzVH2UvOQj68F8qLtz6YIyeWbotTUNNhogyKC73iQaiuruNcqavXr7
	 LGecn8N6bO3pYITcjTuYs6hAj0ytN8rdr2KPzwvhj+dS69+IMPjv6BKLYyuzO9Miv3Rz2
	 o1iHr/R36CH6mLXjDEW4+nJ0E/NWeciovBeeZXFO5OGyvDiz3bWoLbIaOAeI2ZyWKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016562;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=T4H35RJMHyh2IBOp7z6aeHe3cTv4/zs5uyPOML/omFM=;
	b=kqcIIWHWg93D/rwegHtEeDjd/hCteqaGmB2PX0uvnOq5EcEbmOTQsV4jWo4v3AD8ePuN
	 tVReq/aEE3sMsIIvRzjbdxsWdqH9Sg7DLJXZpMHps3S/uv7MCG9vsAUIaraqKPcraGKKc
	 yU5NbOa+BKKC5yytRKwfuwIPoIcF2lggB4dytEoRQ6SDNgwqvKI4rMv0NleeD1umelmMI
	 lIYLkkJX7m8DWbWQtmLpQ6bnR0xjT7EDZHgiiyekVJ/4DTyX4hlVCuv+m0qdbXKhj2wvh
	 fZoPvLvSyuDQOp8SZshrqwkcRgB9xBsBX8dDAm3BFwaIG73tzO33iy/Mg17CKeoTcYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLwUtwzT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E295606A332;
	Wed, 18 Nov 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLwUtwzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9324A1F000C8;
	Wed, 18 Nov 2026 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795016562;
	bh=T4H35RJMHyh2IBOp7z6aeHe3cTv4/zs5uyPOML/omFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iLwUtwzTAzn0DuNp4huYJNoN0XfsHQ/cxc6heSHg+/8XzhAN//RnSWCYH1ggj8izk
	 9Q4kg+G8GLVOqi0THwoVKxhJKsOtznmD3fn/uUHhLNMpv7fK26Hej2DFxrtCXHuxQs
	 R7ry34ly/Jls2i7OiZ0a4NtyF28Ex31ncRnn/lrXiyhqd5GKn0FrXeNaaxtmTsa0aa
	 UaJBZvgoApdKKy+mCiWd84Hs5xJ1Zft4PGU8ATPi/RhV0gIAExLF268YvZipbnYWcq
	 HawhnXNdJAeVR56wQ2iUsyBqltNhlYqwk2KkGlM1gOSZYkOJmFAYNRHN0ksqLERUa1
	 tP2SY7OUB6rzw==
Message-ID: <fefe83ac-4749-4564-b76f-d89bf491d8af@kernel.org>
Date: Wed, 18 Nov 2026 16:42:37 +0100
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
Subject: Re: [PATCH] iio: light: cm32181: Add support for CM32183
To: NanamiKite <nanami@yosoro.hk>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-26 16:11, NanamiKite wrote:
> On the H3C MegaBook 14, the ACPI CPLM3218:00 node declares a Capella
> CM32183 ambient light sensor (CPM0 device ID 0x7db7 / 32183) at I2C
> address 0x29. Reading CM32181_REG_ADDR_ID (0x07) returns 0xc383, with
> chip ID 0x83 in the lower byte, causing cm32181_reg_init() to fail with
> -ENODEV.
> 
> The CM32183 uses the same register layout and ACPI CPM0/CPM1 tables as
> the CM32181 and CM32182. Add chip ID 0x83 to cm32181_reg_init().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: NanamiKite <nanami@yosoro.hk>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/iio/light/cm32181.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b32a940..aaf1af3 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -200,6 +200,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>  		break;
>  	case 0x81: /* CM32181 */
>  	case 0x82: /* CM32182, fully compat. with CM32181 */
> +	case 0x83: /* CM32183, fully compat. with CM32181 */
>  		cm32181->num_als_it = ARRAY_SIZE(cm32181_als_it_bits);
>  		cm32181->als_it_bits = cm32181_als_it_bits;
>  		cm32181->als_it_values = cm32181_als_it_values;

