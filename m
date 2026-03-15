Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE602339853
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773578669; cv=none; b=TtAomAoV9NDM9fb93aZPOLHEf23hMkBNHYZgJk2mQPiQnWgNoXu9AToWBDYT4uOYznGZI1fXP4mK4Jf8dvZ1WHUlY98pLwsEenfeZ3vCUR4djuvW4zSwPileJOkGhNvyUDLci/LabN1JxDOJC+B9JYIREAZRKEasDtJDnTFH8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773578669; c=relaxed/simple;
	bh=zMgKJ5HUcq00t58y1ttrlAw92cqWqtesnrYxBmIaPio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCw1QNdtjk23fqwurr3a6GwjhaIpxIzEi0WuhBfzhDLTXhfw4J0z+kYtqWc6Gjjv0f6S23cBlfLM4zpq6EFfA1ITY3ipUtQsi9PEEiuspeBIu4IgE5DZj/89BqTOieITWANV8YyV5f9qDX/b77tb8pEXJXTeRqYrrZTethbKQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfQ0WH3G; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfQ0WH3G"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1672693a12.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773578668; x=1774183468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRYFJROa/UUot441KnLttDQBP3xtgRKhXj+As2QtiRw=;
        b=ZfQ0WH3GZIzsexYkFxUkc0Z98Lej2022zqYtkHIfqG7juRHSGGewZ1CZxSmyX3Wjl9
         YBlnvtgK0ic3sK+6U/l6t4MJKhFEr1U7kQrIokD7Z5b/Xwiew1Kwtp5uD+zppG8bm/Sl
         dVU9/aZbegLlSiw4T2Jh3BZL2YhOaf+gtkIQ3v21AOPWkmf4CJgikGfqLB+yldvoz4mo
         han3Pgoy+1H+Nc9RuksKs3BBOqJlt8ioYefLo+HAh3LQEqgkpcnUlr1CKMymNyegfjkj
         bYdv7bc9we+b5vGSuJ8Z+l/ydTpT95cTgX6D0MsXUjYVNRbM75IcP3rqnbZ1Ut87U8+I
         0sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773578668; x=1774183468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRYFJROa/UUot441KnLttDQBP3xtgRKhXj+As2QtiRw=;
        b=CztTT7BEzm0Kjeo0KT5pbRlcUPIpiHawSLigYWP2+iFKB0MqR/lJ8mPyL9i5X74/BI
         SKs8b6LNKPok6KQPBQWzZ+IiT3BG4tjxXCaNoY0/1Gm3NDWzJsh5C0W3NEpzK7HWFLc+
         bbw339VfPG8pByQVXsC5nPvVqICUaqY8nnXuE6+V6VkQ9z2Yyy0j6SRX8IcnaMXaZ5Qx
         my+eg+/uWvTKM/nNp1U0ipb/BvYQT6rh2bC4lro5pxAGvSHgwTFEYfHfRfjYpNzQBDEz
         m82g8AZcasPxs3TPlhiaVUhyHLgTmrkeDiNFpKzf22Sswsc3rQxkCtiG8JzNKlov4M5U
         38xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeG4G2Nf1CCPv7WsKvO3eR9178me6txTmE2MrDW4MJYBp7cSYW5tB/Wi0DUPfZbj0HyqwAyX7S2i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMUgWqIXLrQ+Hq2oN8emptsQGzIEKynUWqlneK4aJ60GlufvR
	Jmgp+nK9wI2m95R7Xg02V5wGLUizGyCaz2hgEJwEXSJlLksPV0Gdn4gJ
X-Gm-Gg: ATEYQzyOGS/xDQd05SrulfOkfjL0hNWf7xizvZXQRlXJgRYZXhSF7diSwkkKImdGOm6
	TI+YMyTQMuATONb8VXs8qXOC0nnohawUVPHFO+DIVoScdSCyFISEgK4InPPr5mW9PmyWgiKN9Yu
	oGwbrStSa4X9WSMjDYWfHA4Zhxfxbe6212WfX4nL8n7UtA89WnE7Ub6xM3EW6UESX3lZFegiEiZ
	ydRuGEimNRx1oOO2D6Gq4tW7Mi/PaZaCHFcKvcgu/8vjszAJCiCgtnFigZ/n6brUHG27w8YKQY2
	QOJB++Q8xMWP942TRO0RRmKhckRnKaspOddAXEDh+N1j8AdYPeOXuHWjPPjcA3/an+Tq7E+Cn4O
	8Fj0JYj6TBfaMTtjwTiUaMijHGUvN3iOONIcw+Lx6oMj4BbgyxuFiwi3x+c0meJs+OT/IunkacR
	wqE+1E7WJMPAQRwEhm4gHVtpu7
X-Received: by 2002:a17:90b:2f44:b0:35b:93d8:6ab1 with SMTP id 98e67ed59e1d1-35b93d86c05mr2595234a91.29.1773578668189;
        Sun, 15 Mar 2026 05:44:28 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a243cf81fsm3412602a91.3.2026.03.15.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:44:27 -0700 (PDT)
Date: Sun, 15 Mar 2026 18:14:20 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, m-chawdhry@ti.com,
	daniel.baluta@nxp.com, simona.toaca@nxp.com, i.shihao.999@gmail.com
Subject: Re: [PATCH v4 0/6] iio: fix spelling mistakes in comments
Message-ID: <abappH2DGoqTU82e@fedora>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
 <20260311101007.gaqcner4fzamyirm@lcpd911>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311101007.gaqcner4fzamyirm@lcpd911>

On Wed, Mar 11, 2026 at 03:40:07PM +0530, Dhruva Gole wrote:
> 
> I just tried applying this series locally, on top of linux-next tag: next-20260310
> 
> Could you please make sure to use git format-patch with the option --base HEAD~N
> where N is the number of your patches?
> This will help identify what you used as the base commit for all your
> changes. Make sure it's usually on top of the latest linux-next.
> 
> I also ran checkpatch on them, and saw a bunch of errors and warnings,
> not sure if you've run it on your end and ensured it's clean?
>
> Also, in the changelog, please add links to your previous revisions.
> This make reviewing things and getting context much easier.
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated


Hi everyone,

I have a quick question regarding my patch series. I noticed that a 
similar patch was already submitted and has been accepted, so I removed
those changes from my series. However, I have added a few additional
fixes and the series has now grown to about 13 patches. The original
series had only 6 patches, so I am unsure whether I should send this
as v5 or resend it as a new series. I would appreciate any guidance.
I want to avoid creating unnecessary noise on the mailing list.

Best regards,
Shi Hao

