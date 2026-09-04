Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF85529403
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560697; cv=none; b=o8BBM/Sih66mDhxK4cll41lo3IsbyhQ8nsLm/RAGxhcOItibd4ctrJfjGrwXN0bzQ4NcyG8VrZpujFtbyJ/BkDdZP1efB/T7KAdEsMRXH3jAgkFw8c2XkyxEGDHkPyDgpBCbvw5lfnddedaoYqENsTfHqHNMB244CdLXeqssSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560697; c=relaxed/simple;
	bh=f5EOYNMfX0BIImtJxHv/kOs05uzApSEmnx67CtfuKrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDbw5UR1i1vnCDF/EnKDO9BZCX0EV3St586jTt6qO6OmB1BElnuGq9lDFtPIoBN+aX+uXNCz2+wnVOlP8NXiaC6oDlEoCWDIVoBObyLaH89UnLHWY56bdzZiPI9cUk16JpyaVha0xFVsXJiOXpUSkh6ICzUxmJAJRmrBmhCtAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwj6zj1a; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwj6zj1a"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-867a943b149so27822907b3.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788560694; x=1789165494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROm4P9AhLZ98ncBE9zHDbf3TjPOygTmfSMJu/CK7f+U=;
        b=bwj6zj1a2pBnhA0h4t5ig1hW7S6TDo1BiWsWHECdWTpDksRE2MC3w7VgPdC8o7KJBq
         rfsNOApgp/AOYHBButaxfPJ5lFd30euzM45k9+1d43kdx6XQRTeodJYDagSFNtX5iSUl
         k/5oWX+4QGhoxPN71zI8X+ZFuG0uSUN6Ad037ShXALBFPriLVEQfVPd1uAPjTSdNuu5o
         N4v3mi1ojo4NUTgma5ydPQk8VyzogRnWUi8vQcHGt/yF0sAiT7GHYw6FMJmfqH24MvyK
         pigKjTXtMrJSl7J+IUds1877RqtSG38lX8jD6kc6U8XidwSe9F5HQPiKGrB+cW41H8wf
         1TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560694; x=1789165494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROm4P9AhLZ98ncBE9zHDbf3TjPOygTmfSMJu/CK7f+U=;
        b=JdQsmXk1VPueVeaLq4dql55IkolgeNLwXw+y0QahfYYiqrqcp5VzneY6QzsyOqdG5X
         GfvW+wEm6bUtWfKZhPimbCaamcRsaPC1VF01Lhrft6wwWMht2572s/DQvF1zbGvWWxU5
         w8oIYLj/8qVumEC3DbTfor4bUxcQQw7KDQID/LIhyy3f7x0Yz/8wKVE/hciFUJYaHKDI
         kun8gjUthjpio8RYMFaYgMFLs7Y7wLiS2lki7/eFc7GkNhmLK5JUye2TRI/MU8K7Vjmc
         AaeQpgSKwlBs7w3+vJB67w5M305fDvRVdWfRxzLaUH1j3YSl2LEEmmaJ1TN0YbSnR/rK
         6pCA==
X-Forwarded-Encrypted: i=1; AKwUvByb5eEezGMZwYzUSrYgNk01w//ln0O1jG7zga5tO6XqVsxXKcwS4rTRFLmcSd1dF+gCgKlIc3yf3mA=@vger.kernel.org
X-Gm-Message-State: AFuF++m5V2ZWmsD9NMie8bnnE55x8WoHKQeYMGKaIPEotasAI3m8Lz9W
	xt9BaC1phtDVjKgR8xqXi+Y+MRHsAEzg3yMaLR/cOzyYI/Ae1V+WzYFU
X-Gm-Gg: AYBFou1Sw6xTMus+ch8Taqg4DH5Y+zqBSQggz0LXUp4ScirtcWUiwGsz/iJ0BWsSUhf
	50lcjnsT2pfVLymPTy837LIdPkNiVfDv8q0kebHSaR/VionUN36D3ZzSEWbyx+I48ej+a9kbMMf
	/IlpE0dby35N5uOwcNdOTivGv7I7qkCFaMjH0HKqN0X84RKVhSy7S6oyttJ4UqFBN017B8OoQeT
	DrQopQ8sgeBfba+vRRPb8JydejrL65i9n/e3dKbpjo+2Q57EL9+s5re8IPV1fhT3z5Z9PZ9KXiP
	HqffgRc3Szf9cotmfx++z7fGmNb0CQr2omXdkGSP595fe/m2EIdEaRTCJkK/MoWKXk2xGdUmFKS
	MZM6TzKSd2vtS0kTX4Ey3qz01VyWRrCWAbh4ili5c4tgI2ZRn6Ppk/L8gHSmI+C1qYwUBmI4nHP
	CfOUJrd1kJpu7N7leR909ZwXm5x+WY6HbUP7mozS7lMRgGYQqDnzkdy8iEbHGX/+wdoGtQ
X-Received: by 2002:a05:690c:60c5:b0:853:d1fb:2121 with SMTP id 00721157ae682-87121cc3b26mr48539627b3.1.1788560693673;
        Fri, 04 Sep 2026 15:24:53 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149ebe7d6sm28056717b3.19.2026.09.04.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:24:53 -0700 (PDT)
Date: Fri, 4 Sep 2026 19:25:45 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, rjui@broadcom.com, sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iio: adc: bcm_iproc_adc: use device-managed
 resources
Message-ID: <aptFaaWIJ_azy9Ok@debian-BULLSEYE-live-builder-AMD64>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
 <20260901144030.509802-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901144030.509802-1-mdshahid03@gmail.com>

Hello Shahid,

On 09/01, mdshahid03@gmail.com wrote:
> Hi all,
> 
> Thanks for the reviews and suggestions.
> 
> For v3, I will incorporate the following changes:
> 
> Patch 2/5:
> -Add the direct includes for <linux/bits.h>, <linux/types.h>, and <linux/array_size.h>.
>  Keep <linux/device-id/of.h> and <linux/iio/types.h> out, as these are already provided through the appropriate headers.
> Patch 5/5:
> -Remove the now-unnecessary platform_set_drvdata().
> -Return devm_iio_device_register() directly.
> -Remove the unnecessary backticks around function names in the commit message.
> 
> For patch 3/5, I understand that splitting the ADC cleanup into a follow-up patch would be preferable from a patch-scope 
> perspective.I will split this into a separate patch for v3.
> 
> Please let me know if I have misunderstood any of the review comments.

I believe the above list is correct.

With best regards,
Marcelo
