Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614000;
	b=QJmNzx7OQM1C+pOb8pfZVgnG7uE4YiZr/ppwKnX51wuPq464NCi8xzix1wvtoDPE63SV
	 rMU2q87fVMRMxCSfVjj49Dv/iG/kYylUAHIgvcqzaUgjXBm208dFHIdbEelr4i9n9CrEB
	 yrlko4cQpIEqCTglM3LqJibZHvsPOjoie7RkFy9lKmIUN4o6G42+WCDK7JlV58CPBAsDq
	 ldE2eApywMCDZ8HBu+aiiDtEVWSTy6JarI4yKroJr0a/4XU33anNsb/+odgo5iD0FgTHQ
	 OHLtj0ngrn+b9Ej3J7h4dn5C9Jd0lzZRxpeTgTMgPRR/VI6hR94JB/1QS4I8ucFXnag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QBXIF/5l1vaGNDGQQ6+NMzJS9yRLOCUVrsHNtBN4ZVc=;
	b=4BSOYTKE0/xTEdanw7d5H+KJtDYvNRdLsnOo0sUlKTdTGJ58+kcatqFkzVhixLWtrC1j
	 NKpYoBlNFwMPVVdCNgEb4OnuJgPDOYOY5l6Qrp6h030ZzPy9vfME8TVYUOqBjckECIX/o
	 Ak4KQ0IHtneTdLCNWgra87AmNowCNOfvKH0A8b154Mic0ts6oxcRm6XzrUSU9Twl4I92C
	 VsnIUpf/yiJilojpA+GurwsGnixUVEZqKAkGqeBxL0stU97Wy267h49jIItE8xZrFtlEd
	 64kRD3sSGwv5Ie/w4JFATnpN8Ynvd6V3sN2IEADZumhaMQLQ3lXwi99XRazHJnhTeQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qGLqt68E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D7606A326
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 10:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0D7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qGLqt68E
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b488586facso3563522a12.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793613999; cv=none;
        d=google.com; s=arc-20260327;
        b=srrWgwLfHTFK4PCPaLYZHTOW+LSkfgZxmfiKe+sPBjfsmm1mQjMo5HaK+fcegH3ydZ
         oGzfe2qKwzUCzn0D9D8rUAL8xQJ4ckvt0/wPimgiPZ/lNAoX98gef8WRG5vqFeIy8POI
         5yXElshfTQRRIuQ/9sTdzC6Ie7zcjwMvPcLESHb+/81zEOUc4wTCKxK1pLY0kaMGFHnY
         dGL7197ewNYDpO9DWm5cWVJUJQFmCk3GclucQv6Y9MrhiZBOyY/YtqmvSa1Fw8rs2bkF
         nEjNWJ//aLwEaJuniTUSolxdl92TfEq0WgkSc2jUEWUfdZUj/B/V8ND/C9iSrqGn5p2T
         XE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QBXIF/5l1vaGNDGQQ6+NMzJS9yRLOCUVrsHNtBN4ZVc=;
        fh=SCNaiMyqGLwpwnm3GgcOHTcprICOYeUnh7esqT1nkhk=;
        b=FiFDgNa7y+56M2yMWVeResofq4p9vtsNL6JUJNKBuYA9nWe0yEdRpILU45vqQXt4qa
         EBomJENnA9a2VKP849l8m2jtma1eMTQ9jMED1IK1emCFNwhBqHqqWC6xo7FBNwGUfzc5
         iJ00Ik8lMjtyWY1zyQxl83+ktGsUC2AdlLWjX6v1h0GTkYFv04iDpip9mHYIyrT1yHmT
         qVEDJluKMHDZqTI9VDLxHVk/VVLrzBJ+4Btll1Rh1AzosrYn05ehDBtgLdQpE/AqPAnW
         S5wp8GHoErC8j6OE3UK60xe86aCulz1H004Wr+hvUV/bxrsvKoKZflnMjj4KYC6fzkoj
         8dEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613999; x=1794218799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBXIF/5l1vaGNDGQQ6+NMzJS9yRLOCUVrsHNtBN4ZVc=;
        b=qGLqt68Ezd5XxBY32qGuo49t6Kn5kUBfInvYJRbnFjqY/mMsHL1M1K8zQveYHuWrjg
         LrWtI3le5PEGd3N1uVOdCWOiPi/jYWG1RaVJ0jTFYn4DsoEPtY6ysq3xG8tdHb5De35g
         7EnHjfpU2ixRlbog/uDNxArK2Eaz+mI4Dej6yKGtk7HJPCDal1dJJNCjIm9ZcfKQQWbZ
         yTVzoAmfUZj4o95e/XXp3jzlIaLHeELkg95l+J0F+afRAxVxAVtQCfm6pFhumLOuitfi
         +8UT9WKUFTbGeLy65XpViBgfRHvtLDE/kHod38SwBBH7Dr0wZs/nodQMd32N8Jm0VPTX
         Sorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613999; x=1794218799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QBXIF/5l1vaGNDGQQ6+NMzJS9yRLOCUVrsHNtBN4ZVc=;
        b=mPWgDi9msPEumrnpB2azZcu0GVn1a2Rug5ACQJXI3pJG924yfUsu/L36hBPnzgz4YY
         n+KA/3bNehiyqjqJqPf7jZYWuMpBbHmHLVqRUt3+k4ZgcQC1upxBJstjtHp1bG9OGipn
         0WGon5Nt9BO/0CSkqYR+AsCACmaDublKu7s3IIz3usJ4jxO9HXt1djyuzVLSFqtv1ve8
         ODn9rxvWk/UlouQq3jzd0kMwCZIOiJe6mnz3v8nbr4REMRaadQ7BRSPvZu3m3eNW9dHj
         HLVBrxcgtYlEM815egHYiWBzUyhJXTFd18cD6adX7wFMF/OjEbpDTQl0x1b64r7neHn0
         fR7w==
X-Forwarded-Encrypted: i=1; AKwUvBxIbg08kwsmTyKH27j8DCI3KbLR/9Fsi4bx1YO/GiOsCXEx4hWWbSF0QgI5icR5Pg3ruJkduSmzhUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pQVGG2wQuXc+hgcUIgVrlxG8/GKUUAJIEpqtxteoGldqVzUhd
	6hLg0fM9Oa6SyqO8F6XwZQwmmIyKfnGAueSHLlot/g6d0LRjbJg9FdjFktMhJLvZdZXLfi3IeKs
	wQyP/cchsIKiVyhhtzdz+hkxS0+fANGw=
X-Gm-Gg: AYBFou26dA1U+bCrgPA60qqR4q8HT8eCeMRq89bruEoHPqODn1OuMnEucXPzBJYu8cn
	p2Rz+2T5vGtYzKpmIQ8ii29iR39eZOrGncSm7W/eH1vg4Mz+J77lmNH4qc6EeLXVzRyWuxJrNjR
	LXQg4DIv6oO2DCs1xM+dwtpS68DLUZ6C6rmAmCHUIzjmziYkAzpit69NYfgzl+5igeTzSHmdSpM
	c5jZSbM0sIER6gLrYFHIFA6xd1xUPEhHI09+G9POJrtJk1Buv3E7/KA5YbfHwiKWFidYW5OotWm
	dwVkVO29KXIUt7WkAE17h4M9d0aarLtK40g9rEKIOff0eH0+pLHnZ4U1rwyYYrma28E+B2BjKZE
	NM7s+qQnWApcUHUrsVg/k/uU2ct7MoquFsmU5TtPgncS85O+askHDY76n5WuYf1bM+Ow6A9CrGI
	WHWmf0m60VzDizpUO1XCWS7e4Kt67bTSiF6QZQrd3EMn64Mlni
X-Received: by 2002:a05:6402:c507:10b0:6b2:20b:aed4 with SMTP id
 4fb4d7f45d1cf-6b4d5ee7bcdmr4705913a12.38.1793613998493; Mon, 02 Nov 2026
 02:06:38 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260922032146.321006-1-phucduc.bui@gmail.com> <20261031164551.3637340-1-wbg@kernel.org>
In-Reply-To: <20261031164551.3637340-1-wbg@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 2 Nov 2026 17:06:22 +0700
X-Gm-Features: AclHuK_QeTWYAXcbe3lhxstd6x109xp5zr3EHNsU6jFdL3oMSf7I-uBHHjZQCHY
Message-ID: <CAABR9nFh32hZdWm2nsytyo3MKFtgfPp2kZkSzxvZv9rLeaNu9g@mail.gmail.com>
Subject: Re: [PATCH] counter: ti-eqep: Fix runtime PM error handling in probe
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <david@lechnology.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi William,

> This patch looks similar to another we're considering for ti-eqep.[^1]
> Perhaps you can provide a review or comment in that discussion thread so
> we can address this issue together.
>
> William Breathitt Gray
>
> [^1]: https://lore.kernel.org/all/20260529095834.2561-1-sozdayvek@gmail.com/

Thanks for pointing that out.
I'll drop this patch and follow up in that thread.

Besst regards,
Phuc
