Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8173AD509
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080615; cv=none; b=u/SLuWiYYVmHx4tKQmxYvc90lqLBSObz6Rbmy8j57GDyIHPK2Uxxd7znKoulabu1nDsxIYBXcaHCwfOkxKKbqmjnSGjQ9vJhQTf3cO5MDGKQEnMuSR/ReprB3T+yvJ/49j5nfk+UEZl5sez1C1/Gj+KS27VaX2WTqevpUWkSGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080615; c=relaxed/simple;
	bh=v52Mjwi62THr8BpPhUf0/DJfXqL0R40LgnM6KT3721c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aajekukuIqGKjuGp9Yvn+uxX9ZWUCRgJi8IK2qtPfRqYVD/GwvUW57Qnm/4JTnTr8orw6+FMTX6kdqLJWAGgzfHE6McR4E1H6IffkVp8u0j5MH4+sGsblDg0Vl9okZKaUllzPaZfP7ucge2MxUvrOrtr+1koqmyknrHB2nAxDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejIKQpDu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejIKQpDu"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c1915793so45158295e9.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781080612; x=1781685412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qR6q469I2+mUOo1qqsPYFuouRW9dlXSempBEWNzw4=;
        b=ejIKQpDusPbh/LEc1SVL0gaiHizhUdflDH3jH6z2QSj3OAwPbaEjdqLHGdjoPJReop
         ld1FwFUB1Kp769UrKy/pC3ITMp0qhZlNHgVcE8810A6EmGSSBWU/vVqZPiCszLZggLRh
         agv5bdW8NHDhL9b8jQakQsG2O/4EHdW1YK09Qhm1Q2rqnGKBDl0tcGrPo5j7TyZ/9S/d
         ImDKh7YPzsUQCwtH0Obu/+Se90g3QfZEOLuqsKULQjApel3+1r4WTRCdyZYEGd56/mCa
         xmvEAEet1ttRYA328Ao3pBrASt6b2a/2BKxbBc2Es3RbUmbPcL6MEoZDFnAYG6zyxNUu
         sMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080612; x=1781685412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0qR6q469I2+mUOo1qqsPYFuouRW9dlXSempBEWNzw4=;
        b=dnMlvmuUpXzb/ly9w6lNdBgnSF39KK121Hw0cMR7lLuO+jxX3LqEnqkoavf8AAvxVo
         yG183UuVDRDWmhmk+gGhKrebhTIqHfOy6V/xsBjMLLpmL/S79Sr30TyM/QAZiysN45wg
         kLbelCeHtq749kdoa1YFPjS4pOn34KhLJnTQ6q+jBOa/J6+MmePrK6iacsUAJQ8CZ/U2
         5EFNk80NHAW1Bpx7WKkB7B01AzsU0LOET07xf/BtiA31sypA+WSe0TBEo7saC0mZmaDP
         fNZcXQ/cW9kHd/PCN0DDEp2tlqkkohrtfv5/DC+3zKynv0dk6Bqve2wDLgl07fRzwkdC
         x3Cg==
X-Forwarded-Encrypted: i=1; AFNElJ8kefcMkyrZLPVx4Fs29qbxhBeYDu75ZvuK/0mnkwH+4TaQpFpQ7id7LehOnPo7yzBP6wOHX17PSmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DdQEHBfROFbjRPO1110rNrzLIddpr/LpwqPalJelYZV/1Cvy
	tdRzx356yG03lzstfYGy9pUE9cNw3hYv+D1XTGbeqiQ36pPqp/lqs+Sf
X-Gm-Gg: Acq92OFOKE4rKoGRZ+IJdu7aVL5WbAWwcw4s5FJIu6vY9kRlTKvmfYFF5TWroV0k0ZA
	0wo7w4pfWYEzWesDGJvhr5jNPu/hY8TnoyMERyCZj3QWpE35y/cfE+vv6wYKcY0QrmItSxuKoFj
	6ojtz3tEWYNrAm8FsBps4bj98M2HeVzCLyuZ26h70c5TcIHlHUXQd0Mvch2FHzXScLFkzdZWMRO
	31u7OUMSk88Hh3GzYGSigPpNHyVbCTxBmN/TVtFod+26nLcPxsuvLqWTF3LZwJCaBa63YFK65Gs
	+o7wwYU1h46M2uD5QJEs77LAD8bECEXX0BO/jNWXZs8Y6pByVR2Q0XhrrH+t8aZDSmMTcIWKLsi
	vc4Hmqu6v2vXDHES478eKhbxeqaW9DE0a//C4Yc3r4OVnIh5NWOP8SapnWy+EF/3zN+HZoRgXOa
	KHzWmy5uqgpiXvTkfAmFsktA/YWAKJ0Kz3rvhbyLNDgNeE0Ed7JO3Y35z87KcrWXA+s+3Ealnwy
	9CP79tj3AR4Z597YAumwXJw5kLdgVzkRdshD+HoGb8CXLhoEjGn8VMOcLQIgXQg3nwfAxCx3U4y
	UmUC+bRy3r8dZmKcKbl1QI3OTHjBKyodLpv1ct+D/LOH1ITYUCkDZYpAiB3YIEODiaCHTXkV/I6
	2
X-Received: by 2002:a05:600c:45ce:b0:490:b35c:88ea with SMTP id 5b1f17b1804b1-490c25e74b7mr351105745e9.15.1781080612225;
        Wed, 10 Jun 2026 01:36:52 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm549570885e9.6.2026.06.10.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:36:52 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:36:51 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, "open list" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, tduszyns@gmail.com,
 mazziesaccount@gmail.com
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
Message-ID: <20260610103651.00007a64@gmail.com>
In-Reply-To: <20260609102159.14c68a8e@linuxescape>
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
	<agAvydze87mMLaVC@ashevche-desk.local>
	<20260608085754.32def4cd@linuxescape>
	<20260609140712.2e5d1640@jic23-huawei>
	<20260609102159.14c68a8e@linuxescape>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 10:21:59 -0500
Maxwell Doose <m32285159@gmail.com> wrote:
> Alrighty then. I'll probably take his chemical/ drivers since I've
> been spending some time in there. Regarding his light/ driver (ROHM
> BH1750 AMBIENT LIGHT SENSOR DRIVER) I can take it but I want to see if
> anyone else wants to first.
> 

I believe that there are a few ROHM folk in IIO, perhaps they would take
interest in maintaining the driver.

+Cc Matti

-- 
Kind regards

CJD
