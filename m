Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C53624A9
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776420324; cv=pass; b=oWX0ZAaQzkXKuuT7eIpIW9oZElD3+aaqHgOHzXsn1PMhXsW0/fNiZippr5aEs8FFFeDkCFMerAOOf5qyjfgP2vzCyy0xgooZR0bjenNHZcLF/IGSWZgfSyOFl2FTi4f+89V2qr/0nimwWkALud6tHxFmay6mWgoqrzgEMM2JQp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776420324; c=relaxed/simple;
	bh=+7oR4wXUnn8Gaj0KwrKTZhj7xplX1SNhcNEyEcGuKkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A34RWQ/AM1rF7TprDLDCMTg+IRHQdyc0BnB9VqG4D2jCYgKz3daNGFTB1HMSAUjkY13r3hwYLK3nwwjAemW+Ikfki2pe4AmcJdCH6YL79RiwSRSWhrl4wwwnkw7KHDYWZ/jIXilJXmQWeocpMe84HD+E80cxJEElkQOnP7V0Pzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksUf+ybl; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksUf+ybl"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d73422431so353237f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 03:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776420322; cv=none;
        d=google.com; s=arc-20240605;
        b=a6yIAtPU2ATMjUQiptyiu8jfKmPP6GXHU7z4FBW5NoYtQznTRRAgg6/PiNqIkr0Bii
         LK/MefaNWCw1xZR7R6XYzkY/UEPd3aXK0b/lSjzKruGBzxvmg8BS/M5VTYFfmaOGJxlC
         6brqdrzqmbkBrPgLMTEhoT8uCwjeO9MK911wZ4atluvZfey3p9uyH0q+5QkGnpc2k1KL
         B5q7i6SL0ygIo7AfAW0EVzj4R1eI7GUUypriHjc0PcFwBM0P22ba5Dig8IIPQzLK3zeK
         Xs1Z7MuAj1kY7Xo0nymbD7R5EEW6LDsIzXvCLiUEGG0d1z8a1gIJxpVhqkzLl9FCOtSl
         tebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WHpdlUHvf0JqP8JKy4n96Wp7a43y4nLGj3BUPXsQMgY=;
        fh=BI0WBTPD1mYM+bzxeLwBJOnlsr90REpwWQI+hO12SFs=;
        b=EBbLxlc4o9DBI3PZvOAAdhnTPLqm4uIg0iZ5Ds6NsyeUfmFXek2XcioIcJpoKpJ8Ro
         zuJFtZ5cJcJlXlppD5ObolURTT+zytn3vjC02dTcmb2MNQ9CGuHUjM5aoC/hJAXVOytF
         ts6xQim9ctFYWaxTc26sHiqBMfafpYEszrHECAu62J/rcNtDH45TAO7CgrJ0CaL9BkuK
         U8DwI+vuvT9XCF6yvzIGDU1piQEa5r6o1h9heTLV0yc4MYhZpSP2ljo9blEOkipNvQos
         3zacyZDfoH9NdR4o0t71fcAOtmdRH7+9htW8uGTL7cn6MuDodbAim12eZJyw/BffSBZ6
         8KFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776420322; x=1777025122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHpdlUHvf0JqP8JKy4n96Wp7a43y4nLGj3BUPXsQMgY=;
        b=ksUf+yblp3EB/AKB3r7QoFNerST80M0pytcpKLmSE4VVWWLU8zA4WU/vDkg6QH20WR
         h0Ql3xq781Uo3nVcQuzie8ziX48Xf9B3ypq7YgOJaiOPYSEa39z0NFFHzNP80YdPiRXD
         IUalSlkY1VBOtw8pGP0PW90OLiMybSZIAQjx7G10KiGTR8TcsR91R7lk4lb3br/qTEz/
         m8ttpbKIovd8OurhjOduMveIwpuyPv3UqRKSrJtK/+VOYI7mILqTiNcg8JaLMUzZM9Mx
         ZcluVcwfVJeq17ishK10tpa7l3k9M81siaa/3+zL6PmI0kaON3lvgCgwulQAW7YMrDfY
         SYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776420322; x=1777025122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHpdlUHvf0JqP8JKy4n96Wp7a43y4nLGj3BUPXsQMgY=;
        b=ncRhUAzjY0+9M3wkG0B6k0sSyPh3bYYd9qJKfVIv66qTJWLJhWppoFtbZvO5ENcGq6
         1WSpRdRZDk4pR8Vlb89QIpNrA397vhpVvQFaGlo6BA9kpaLW+A7oPssHhAt0Tv7Jd68v
         DFIz13BOsbkZqPgU8qYXJFb+wpZ9xW/xoFrq0EzLwRS/BDlLlGWG+4Q9vFkvkVSMIG01
         naFx20vhU2JV3qR2Ek+ouquWq4Obv9jdp6HAqC13jMkHH66/MFfXFsVVbWVhkin4tqw9
         H1UDKB1c2+MJKvUI9f7CVwYru/KoogBoPs/XmOonyIDK63PgrkghtRHP2lrSdfy/hjtZ
         JlCw==
X-Forwarded-Encrypted: i=1; AFNElJ96q3zfunr1OhAAYe4oU9EIDdT+HeueVZODy/D0SKpVbecV+s+8qMJwwuf0MiVaNGysBxiE+qj8hAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTrd5gndYK6RKAAjv/XoOYJ4oLVqOZmJPfICA4kjaPWFrqE6E
	vYhKbsu5JVhYDhYVPTLF6Tr+ez7I820EqFUKTIJHCtgT/d8q94G6biaZC3S5UBzIL6upqbXxtR3
	rXJJbyzf/Nn8/zqVKtAGcPiMabnDIO8s=
X-Gm-Gg: AeBDievWXCUJMWSA4fkwsoPk2E3XgrUlA2VUSuOPM8ToH8mUsSAvqnVkj/38Z/DEKta
	Os8g/9QtAWNoRXoPk00Fgl0HKi9HcCl4FomLBfvJjhDi/TZkfR8IuB2t0JrsK2i21Wrbncy+TlA
	C15BIs08F5CgQ2RbST8JIk7toTgbF3ojM/jXxebDS3/2yMfPCQ4RT7Yvz9ShphJIPcQzvi1oc0y
	Uz5FsGWHVkSDH2byLvR9v5xU7rUn9+eKhV5BPO5TM6+RIfJ0+WN4S4WwFWGgBavfkuqYP2MChJk
	aLAPymobfep/EtTd9SQbRcGBdzPYHtdzOc4ALhstsXD8B5dWHTcB9KrnTvteAaFoNRXOLa7V9r6
	riI2xTCmB5agfcE/JhNAX6j8dFJikEBoUSc1cxVga864tTa5otWyk1jGORUvTLubO1BI5CPSE0o
	o5ZnPeGSo+ziuNrlvc
X-Received: by 2002:a05:6000:40cb:b0:43e:aa43:243 with SMTP id
 ffacd0b85a97d-43fe3e24eaamr3235593f8f.43.1776420320937; Fri, 17 Apr 2026
 03:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
 <20260416065118.1299-2-joshua.crofts1@gmail.com> <aeCe9Za3aGPiRFC1@ashevche-desk.local>
 <CALoEA-wTk+32wUv3M_wLX-+4Fi=6BjLh6UsRZYqQM1Wcf+-+5Q@mail.gmail.com> <aeIEoJnkzO03Rz01@ashevche-desk.local>
In-Reply-To: <aeIEoJnkzO03Rz01@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 17 Apr 2026 12:05:09 +0200
X-Gm-Features: AQROBzCuv-2guxSm5zgImEeJHUB-bHU1_mWumwCgD8f3XtHrpLE5GMtbr-NeQDc
Message-ID: <CALoEA-zf2sVtH3OgauPSTy9O1xaXrUKNHDBhZ71eqkMn-9XYBA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: frequency: ad9832: remove kernel.h proxy header
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 12:00, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> I don't see it's in use. The pointer to it yes, but it's a huge
> difference.  https://en.wikipedia.org/wiki/Opaque_pointer

My bad, that was an oversight on my part. Thanks for the
clarification. I'll send the updated patch soon.

-- 
Kind regards

CJD
