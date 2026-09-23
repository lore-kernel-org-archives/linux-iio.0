Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF9408017
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142510; cv=none; b=iAyxh0fF2F8rZJqFjiYTkOyRbczhaE8zWGGATYrdDCoDFplAg6gZKngvwItVdNBbNUKjMnSiL91XSzMqZfHgpmdvVRnRfv0qjO7t0eV5fuESeGpBBzEiz6x9brSE6SkqZ7hcLmmcEcICHD9WqWpmaRaomfksDAXFZGbNIK+18xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142510; c=relaxed/simple;
	bh=gl9QNxpVNWFvGSF+14VHJu/hzCiJZCNUXehAGjUQjl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3Kziub2XQ/7Lyfmo/7pVTipwxdnIaq5lR+Egh2TnhHFAJ/QehIq4X2CwFAo0FpkuyIHPjn43Le5HEQbaxU+Zy/+IdsOX/+r+Vza1gOcWfVfVIqjh4l+fwDq666NVGK3tcIXJvx7aNbXIvUveGnU8em0RbDivkGvrI2az7H4//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=teMi65+Q; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="teMi65+Q"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id 8Zdexu2ZgFNWB9FqGxUb7A; Wed, 23 Sep 2026 05:48:28 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FqGxpRMwIRv99FqGxhLz2; Wed, 23 Sep 2026 05:48:28 +0000
X-Authority-Analysis: v=2.4 cv=GIUIEvNK c=1 sm=1 tr=0 ts=6ab3682c
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=sb6rmjhbKkxEEDQ9x4kA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=8MP6MeemUvE5VW0zgX2gcLMeyAh6xUJ+Tc8tb18g41A=; b=teMi65+Qmq7Z
	1EqZ7stbs37L5otsq7nuZ7CuMVmCkMShzSWe9B8Re2I1YvbGHHwU94j3mEoNZ9l3l3rxFVWTKyBRV
	txdW7wukIm6ykYHnn2H/EjeO8G8XDHENlgkP3pA5tAb9E4sc9zOF6ro8OTeO1rDRar93dpKnQpOzT
	1ntFAv4PIcq56brQUGHtRuc51XDoUEgLwbgzfiaA9rH7wIKB6CXP83+HqX8X/yYJrgZPuhW6Fsagz
	3SfGiHtIbcqL05dgIy9cBkbvcDDmhbHifhRLpyPcrDnlJJIo/f6uyHWPbFaHzxYV01PhcCqJCFSaG
	rSCbpeJoCLtFac/uk7brJA==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:51746 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FqF-000000024Zc-1jlI;
	Wed, 23 Sep 2026 00:48:27 -0500
Message-ID: <63029388-6d24-4fc2-87ac-58c2499a3e14@embeddedor.com>
Date: Wed, 23 Sep 2026 14:48:24 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: add __counted_by_ptr attribute to channels in struct
 iio_dev
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260923042825.2558762-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260923042825.2558762-1-morbo@google.com>
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
X-Exim-ID: 1x9FqF-000000024Zc-1jlI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:51746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 67
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB2CNyHKZk4Jj+FYf0f9xkBzdl6HZ+/a/Pxqx+fyo2ZB4upLdMU1AchXuHgCJStoljElwGLGmjuu1MIyDISsc1/rL2w84RfVxGd+z4nU34AxcCX8F5fc
 yc3Q0qGvS/4bcGEkknDkR+PEevffebVYZxq5zLjgEPLrF4CDxSNtRWcAvk42yje/JffNuZxkf1pOLTbGUY22jj9cXuwx3vIAa0c=



On 9/23/26 13:28, Bill Wendling wrote:
> In 'struct iio_dev', the 'channels' pointer refers to an array of IIO
> channel specifications ('struct iio_chan_spec const'), and the size of
> this array is tracked by the 'num_channels' field within the same
> struct.
> 
> Applying the '__counted_by_ptr' attribute to 'channels' allows KASAN
> and compiler-based bounds checkers to verify that accesses to 'channels'
> remain within bounds at runtime.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/iio/iio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 711c00f67371..20505139a61b 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -648,7 +648,7 @@ struct iio_dev {
>   	struct iio_poll_func		*pollfunc;
>   	struct iio_poll_func		*pollfunc_event;
>   
> -	struct iio_chan_spec const	*channels;
> +	struct iio_chan_spec const	*channels __counted_by_ptr(num_channels);
>   	int				num_channels;
>   
>   	const char			*name;

