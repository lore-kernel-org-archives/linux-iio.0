Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904F3876D7
	for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774696784; cv=none; b=JGcmtLehkTTpA0CX54sBiHjjCMMdfLEf6ON/saicTrqrK/egVYIfxkjK6b++pHzySgoeAbDupcNsMJ68SMOsVXERMLkTBlnHvxXHoxya8MdHcIF8FFcLtsqwEWkKIU+mRKD1y7G6w52nGhNm3APwjdWYXQw6JgAOTckzeaqMUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774696784; c=relaxed/simple;
	bh=WsqHrY2UBEjSfgoMPwgaCP0ADaekqgHFCn921u4ltsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1xbI7rHeKhcmdsEzs3o39iJmk4LioPXRyH1weZrnLKVkSfUAqjkOhJcGcNgeBc2cVfff/Vf6Ye8KAGgQ3Jy4QqHx/0zFcIWMkgct6caFaX0RgoHgxjTwSXbzMoNZkYt7vanttOjM6wI3UGr6NhidCily/2P93HfOPNpYJjlWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxjq8swY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxjq8swY"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d965648a2so275534a91.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774696782; x=1775301582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65/A/y0tWnd6/1Jr3K1mW/81LhIv9paBXlJpScLz8OM=;
        b=lxjq8swYgOTzEBC5SVb0CpvtxQkeGi7yOwbrOTnSi7CxgEvyUoRMizPwehdbfZPbAf
         6V8dJFSq6YulN6UuxHlVJlE50XJiCO7L50atNbtisfRemMSNofeg06SBFP7F85ctIxgF
         YKY94Wi1GJKYor7F4WCZg067WuAey6FoZHPG89t7y2e0Powwi3WWZX/7om/yhzulXNaI
         bQ8rMBpqH4iVA7kcpVYBoTNQpmXeTz0lJTvAhqGd1nvLo7dOepIRS4FL9UfTMNqC5FYD
         CuMz/J2+jecVf0FHOvU/TuDngF0czE2x4JN3lpvcJRD96isAH0pSLV3o1jfYwBGMSvTt
         koOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774696782; x=1775301582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65/A/y0tWnd6/1Jr3K1mW/81LhIv9paBXlJpScLz8OM=;
        b=py/8r2agnZf8D28keyakKX1yCmcnaPFmOdiIri0RMysRZWJPDmIMivl9sxNZ6g2BDH
         I8EWP4IL5HTreW4tr8dV9k//cksWuCFk4k6XFStqGEwRpcXWuMRhZL5zyZ3sLBSRttaz
         RC/N8LsoQY8ZAtrj383Wr7TByJMHiH2crXAIGhzlWhpC2Z8K3L84qvw0Uaa1Sw4lQA7j
         4lMCunujMIQDoSNlSi/YTHQcCH+2EgwAGMDCpi4tVzpPaXjtI04UJocyldzA3MPXS4q4
         6doF7r8V+LfbmNEZz0+tmmqdSML/e9Ye5+HubuIeYNyBmORtvOjzJRrfVKkIm/2e6lWw
         JYCg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ilo4Tc8fSdBf18ZEClZ8xOC1huMgreL7DRkHBhUDMcZ/bDMbDCmioAxrb296q9qUn7IzjmB/Ips=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrz+uqKtsEeefrhxy8FW02BmcSXs2dREmMm5SH3j9EqAVxbIpc
	LwhAv/3UgEvUPJNoYAROxRhEYV6suS2834lbQvetEliEFzlGr3y/1kl8
X-Gm-Gg: ATEYQzwJnB2PmqAq7yF9m9rWZivwF6Z67ZFktMx48499erALAZdrTPcsDUGT7X7mB1C
	Mh1mYfJ9K0Is7E0WHS8LDP86N901ZmZ4HaOvB1gQAwHepNvxqtQkOjnHGF9VPWEm2YQx9aozdgJ
	N0bsgvlH3WTZH89GKexVMPt4SLyMSSeIZ9TrkAxmCpF+JMaXdqsPR4bxz6NmERe8e7c4t5lywJx
	57cFTFhGoCP/vC0C2AYX/EkPsbJDHJsYHzBtQaCneaANmW04/Qkm8xHyFW7MtWPzZMtun4nUzLb
	LwAmOKhIT5230TBxrRkD9/HUU3+Zhn2CqNBeF/F7/kXSqVndQekAUJlzZh68lPUII+gvDQ0QYRm
	76kSl86B1yXxt7877qVeDdp4Q0AsZF95Tpqegi8hDt642+zYEV97VDcsS4vNxf2HbdPJLFUC/jP
	fGveWiaastKheeC9MQ9UaKtROB6zXpkw==
X-Received: by 2002:a17:90a:502:b0:35d:8f3d:c554 with SMTP id 98e67ed59e1d1-35d8f3dcc71mr1989001a91.13.1774696782074;
        Sat, 28 Mar 2026 04:19:42 -0700 (PDT)
Received: from fedora ([122.173.26.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2db0a951sm1848568a91.5.2026.03.28.04.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 04:19:41 -0700 (PDT)
Date: Sat, 28 Mar 2026 16:49:05 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, i.shihao.999@gmail.com
Subject: Re: [PATCH] iio: accel: bma180: use devm_iio_triggered_buffer_setup()
Message-ID: <ace5KY5ov0nwXqH7@fedora>
References: <20260321114848.159973-1-i.shihao.999@gmail.com>
 <20260321130018.5ef955d1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321130018.5ef955d1@jic23-huawei>

On Sat, Mar 21, 2026 at 01:00:18PM +0000, Jonathan Cameron wrote:
 
> This also changes the ordering so that the remove() path no longer
> does things in the reverse order of probe()
> 
> Whilst that might not introduce bugs in this case, it makes reasoning
> about race conditions much harder so I won't take code that does this.
> 
> The basic 'rule' for devm usage is that there must be only one transition
> in the probe() from using it to not using it. You should never go back
> to using it after that transition.  That way the handling in remove()
> and the unwinding of the devm_* happen in reverse order of probe()
> and all is easy to reason about
> 
> So to make any devm_ related changes in this driver requires a
> more comprehensive approach.  Note that even if the change here didn't
> suffer this ordering problem I'd be pushing back because of the partial
> nature of applying devm in this driver.  + a complete solution would
> not run into the ordering issue.

Thanks for you review. I will make sure to remember it.

Best regards
Shihao
