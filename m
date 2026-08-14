Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76427FB37
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671494; cv=none; b=Vnwp7M5zxefWjnsffuGs14PoFxXiaEoEYUiCWjZ+nNNz3EjUPb0fRibexZJdb+6J6uzMNUrbKo1QYjEgJ1ov0r9D4P6KOCI323ksFm/bq4KmmoJAzH1Aeuwifmq949e3xlgVFmnxHsbvOnGPMFK0dk6GhADeoISWf+0wYdB3nxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671494; c=relaxed/simple;
	bh=wH2BVX8rQi+9ZChgxotsL9mWq6mp/O3ySdn0wNdJCUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+QD4z+DM6Fd8IWfTJQwT4CEUnqglu42lRg9DVzxAfQux9Frck/7epk5h3Mfs2ayi3GpIYfdSLsnXbnZ10V5o2tid/tNMnMGpX2KDJXORLTePidOBVRc47ty3r38T1rZgi8N5M0RmsSRi5Ks0vm0M/f5eAzEzMmQdGGh8K583J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY5yG7wA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY5yG7wA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedf433a99so434065a12.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786671493; x=1787276293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wH2BVX8rQi+9ZChgxotsL9mWq6mp/O3ySdn0wNdJCUc=;
        b=RY5yG7wArEk7CuQX56iKBlWjiQs0LN5uzSvNel2XPb+ujlDn8yB9AeEtWuoV6kzxAi
         PHefbkJoczwMUAKlxMtkr3haogIH3r8vNbfy6K6ao5quZa4azTm/TnTEIOUdfH1Rr8L4
         V62ZLW2zq4Cr2BCrxIWJd1jsoiWzNx3K3ik2MFNmXqpATqAE9Q6Ttuuv+Xdta6lvBDEt
         y2TgA73jLSbVlvFG3Zpgzal7rlIBJcHnMQxkkw+jLLuDP/duP4rP/38DOjYT7TdbvOW0
         EmhxcIlHftDfrpmOTGUHlOag8Bnl39RB92yCtYgiC6iMu64G2WLmgk6chyoKCIDs7TeF
         UOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786671493; x=1787276293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wH2BVX8rQi+9ZChgxotsL9mWq6mp/O3ySdn0wNdJCUc=;
        b=fUSha6+9n7an6o0gJqpZCxNYYTp9C+N9VrHlvJLf+1mL7/C7HCt7+3ELjUDUj+2UJL
         k0VrCb3lewK6qLqOxF96LCxniKeKBygCW1gMkXCsKY8YseAtlCPEz37XBhbgajepsFx9
         g9vkHu3XDdLF1za8xrjxU3t3jKZW/8x+kgCfmU+aEKDKsxGxVXgh3DchpowKGRHlhdal
         m79BbYkMk7FPdnvjqG/WTZ3hhoZ53xX/25H7A9IPBTqEpYclHvBXI1GqYKRc+zPhiakA
         Iir3Q/FWAroV2DS1qelLyml3KXmboxL/DvqsUaUlm07QbotrEazy3UgSwQl2N1lo0wWZ
         pWMA==
X-Forwarded-Encrypted: i=1; AHgh+RrbT6e04Cjqf4wWSf/B6Z1L52iLAqozxouUU9rvxIbrmS6IAfzFwulXh6wn8lORksN8oTy5ao624SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9l53giUH+Mtmp2bF1z38RErnl4iMu8oLcYnwjyo+Bvg6Umpt
	fxNfFlkZvLLJlF2MxLguiArH1qytkp5EQAq13Z4j0lL96xIESZBMU7AA
X-Gm-Gg: AR+sD11O4lSPsEpEJGSTl3NhmTFPOCke34paSU8e2QkTrD+3ZAnkhFrRjJnNXRY247n
	KRMaJysC8IuI6hUG5QVdnfYpXy6Oa8Pm8bBV9iAZU0A9q7jsxK9sE50ehjusKUVNyLrKb9OjeXi
	4pC0EJDwQqa8CeDTt4F78pRRwd57sG475CAXTZh2VgPl8sVdisE0TaTRhu1wVAz+mya/MoNaA6s
	s3Vxofj6XS9r5L8Fl32wvvISUB2gf2pxHuJHgASd4FJKWOuW1mMYFt60Qbpz00X4M6OdcPYvjd/
	l5+lRiCW4FjeUfxeYVXzalgzb06V2IeCXZ10d2NbiyRf6Hz01LN86A39Hp7ijZv6BIF9ufoiyKi
	/5edDSR6vMuJKh+05Tze8N8wswSRvyJRv9RObBm9nr4qgSeAlQFuVrrW+qiSA7ZDazQmZoQZ++Q
	hEAJ0by+m0xdXSHPShSHShUaIfwNBtLI3H9rSjiXmXyM01DekMMUW5ofWwrJgjoJzFpHN+gbmWp
	0hnTZNCHEz75tL4B/F5mFWIW3baTeSNvw==
X-Received: by 2002:a05:6a20:e613:b0:3cc:55ed:dbfa with SMTP id adf61e73a8af0-3cc71cd3ee1mr2390054637.27.1786671492726;
        Thu, 13 Aug 2026 18:38:12 -0700 (PDT)
Received: from localhost (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387accdbsm4104230c88.3.2026.08.13.18.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:38:12 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:37:59 +1000
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <an5sgMDgj0ceLfmc@fedora-1>
References: <anrwMci5d2VW56-X@ashevche-desk.local>
 <20260812044941.6f28cfb7@jic23-huawei>
 <an0jTpda_06HUZcw@fedora-1>
 <an2Aq-wKsIZPvJx_@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2Aq-wKsIZPvJx_@ashevche-desk.local>

On Thu, Aug 13, 2026 at 11:30:35AM +0300, Andy Shevchenko wrote:
> I see, so why do we even bother with the _FALLING then? Make it trigger LOW
> when it's not defined and always enable sharing.
Makes sense. I'll clean up the checks and pass IRQF_TRIGGER_LOW directly.

> You can't avoid possible regressions for the cases when firmware neglected to
> set the trigger type completely.
Thanks, understood. I'll update it and send v2.
