Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD543F4D8
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110962; cv=none; b=N36f17duA0rTcWvW0Z8BI+IIRlp/p4sCZyVepV1nSldYUAbF9UCgNQxNBv1YFxFF0ApbAFvbaNnOVZjo6VHlcipVVEtOp/4T35jtV8NwnhYQBRLuFsk/O5Ojco+FcZmajbbx0/3jw85dhkJViPXqS5dTovtEUypOsKBYIlcOJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110962; c=relaxed/simple;
	bh=RYsCY38hXfetDYpNXSv6HtboJtdEpHbINpvt31eP/o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP0s2C0o3PpcA9OkMLmg8pxjgBz9iK2aSkWe7yUPi58krV9i9MBLq3h+L2l+mQiqiHkJ8WQoQAbapyGbNXkQbjanRbf9viA2PQKK0YzDHe+/lLmZP9PS78+k1IIyFoHeRYJRiy61urz5aiO2lXfftNsg7Z7tGxJmqCOq+AaPh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvbmfKRz; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvbmfKRz"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a38e51ae95so1213024eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784110959; x=1784715759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFRVUyNnsvCbhkxmCbV4fjw8KVL0SYAGHoyknd5Huqo=;
        b=jvbmfKRzTGWm1MKyu7Wx8HYRGdBSslbn5kTUIlQXcBHcj7ibTDuPGO54ZxYYkyZ0b7
         /5DCotcBS+Z7hR4aLWV3d5wC321abbdqFKLsGvrVUYfp8zUOr3x1ckUVySuoWsgPc38B
         B7OjGORir+p7Bhuc+bnLkPYczsmezV+aviXlXqLLDnnXEOZCDzfvzrbaZ93TQE02BdCU
         zcywqJbV7XzreB+THMylVC0EhKIRMfgbt7KGHoYGg5u2nz8D+FS6w/i/uQhvOidWAl2G
         5ZXz7gH7POXqO/3cJj6XDvqRXsH8ryU33Tvdi+lqwanCxPItgJgs2g16XqFzG3eqO3K7
         3wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110959; x=1784715759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFRVUyNnsvCbhkxmCbV4fjw8KVL0SYAGHoyknd5Huqo=;
        b=ZUzaAJkx+zQbMvt2KGU4//rIREGicooZOoScyHNATBoYLFQw2qoqQh8lVK6bIZepKm
         cWspPgWjdxq9g8RgRr3KLgaj9uhYMSh4EtGsdZhyyOE32C5hFa7T/TXsXrifSyV2wSYd
         7sx4OP+vyjKWBOOLA8oWTElRPrIM8cRyZt+l1oidJfusAlawSG8TJCWFxJiZpOENlFt9
         KmCQhf+eoNqt1KOXMzMUPe2Ltnwvn5OBjkTyl3flmPWycUNe7lh7YCntPLRCy9JDjOnb
         LXYHFWm7t/JckABnpeHYu1Ub/eCM5TTimXqqJxgOXU28cO5dtifbDY1C8ebV89nFqAxs
         2M8w==
X-Forwarded-Encrypted: i=1; AHgh+RokwKMc/X+b7WlR/uYujM68bEA2oPhPOgMUIRqGSyJXpebe+C1907e/3b+gwF67KJNSYHQSu2sB+nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNj9ZFePtRh7TDnUllgSPo4XXKUgwq69W1xcshSl1RUo2Tpmf
	PfvRzWuiVm5ueZ+VRwggWg1FxRmwgEBZ5Iq9u3VLmvNX1XIPKl1qbX69
X-Gm-Gg: AfdE7ckeMVpFFoRfZzo8iEVyvMQ+AxkLJsYnMrxCJwfQuN+E9XCeQ/qgJVaMuY7TMGc
	ZBZ4CBuEx1LKG8aiOkPBJGlTmjdMVLbHgl5ba9ed+jxf++fJe0ODh/+H6AuO5aO3iBam1bgLnqf
	MDvD2dSFFBjd5kaHhhkaQ02VsSTAJ1QtrlWIV5qERJ66y4niEq1Q7SfBPaeY3/LJ9Ms4krM1Sc8
	tkQ1zLGWGpefWhKW4om5o7uE+YKdmv7fK0sMhZGxiXshY9v63GJASrxUyvMq0XCmC71mG9W03Ml
	7JHsoaxHmD4g+aWncbQCb3SU/dvVM3D988VXoEhkT/nCx29E13gP/CURdDL72Kt5vp7WaChhQfo
	Gid/ORIB+QO0arxF5ySvVZc/9Gv4A8+JsxC3oOqC9ugTT75fHmhoBL9Xa8kDNdzKOV7QtuNKRfL
	JJbHb2
X-Received: by 2002:a05:6820:1350:b0:6a1:8606:44c2 with SMTP id 006d021491bc7-6a3da05ba34mr1315522eaf.54.1784110959511;
        Wed, 15 Jul 2026 03:22:39 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4561f2680d8sm2782008fac.14.2026.07.15.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:22:38 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:22:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
Message-ID: <aldfaM2aks7qOz2C@stanley.mountain>
References: <20260714165012.184651-1-colin.i.king@gmail.com>
 <alZs-uLJug_rnRnq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZs-uLJug_rnRnq@ashevche-desk.local>

On Tue, Jul 14, 2026 at 08:08:10PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 14, 2026 at 05:50:12PM +0100, Colin Ian King wrote:
> > Don't populate the read-only const array config on the stack at run
> > time, instead make it static.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> In all patches like this it's always a bikeshedding possible of moving static
> data outside of a function. I have no strong opinion in these cases (when the
> data solely used by a single function), but in general it might give different
> readability experience (it's harder to notice static data in the local function
> definition block). So I leave this exercise to the maintainers of the respective
> pieces of the code.
> 

It's an interesting point...

At one point Smatch didn't track static variables and it used to
generate occasional false positives.  And it's like you say, those
little "static" qualifiers are hard to spot in a wall of declaration
text.  I've never considered moving the declarations out of the
function scope but it might be a good idea?

But in this case since this data is const, the static vs not-static
doesn't affect flow analysis or readability.

regards,
dan carpenter
