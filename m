Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48343CC9E4
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927078; cv=none; b=c+C74i3aClY4XwdhIAukJulAIyuuKpyJZbrOeUMJoR0R7JddyGAiZW7v9VlvugJ/cpTQWSa5upqv8mjWZIdv2vg4Kpyr03CQIAGfcNbni2neCN9MOlTI7mmkDfDAUD2tZ6xgBrMjp/UQAp3GxiXdpgjQXcJaZRdQ6C2Waw5o8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927078; c=relaxed/simple;
	bh=K/FHHCYqz4C1qnj2tfG7nVmJTkxXsHMr9AOHtIO/C8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdcJ9wzWYFxd//oH78BEInwJc+OPPXYacCClTAICc8JFkX6XlhmiGR29jUdbHeP9Guly2grrU+ab+kE+VOlVb0QjSKyBeI0kb2UvfCPRlpcM76X5kLGikDB1Aq+P0m7B4kHDp3fW4XLnvZolCfCYRH+k9lcE3HKmVutJLtuGfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjsKaP08; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjsKaP08"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6b5737bb2so3589327a34.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927076; x=1781531876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8slye6QO3nIlTUvISIckvPExDxw2ajmT7nTGEplbdoQ=;
        b=VjsKaP08CPJW3yXq47bPd6ASkX61b5/zED0rSODzV8zb+jKRrxRtbCAhKHUROcXMaP
         YworZGoguv93O1o7AksM1zxwn7msQyOJJq8YUqvgbORa96o8PTYoZ1wHRfNuDAKQIZNF
         VLHVSNrWu5bRV7zUeoI9dqF0W6+ppZySYYPartrq+qJtWfG/RJbNI+1uIevSOA9BEoHU
         H8AWiLv8+NkhSzlkjSiIgFyjEEdRYEz9adDDqYvXCIFpouRO5diwi7xxTwAUCNAPRj30
         4ObLJOb5tgw9FoEIK2eCdyAvudy2zppNmWXM806lVBnHyFNrgY9B7LdfeQVP5HTAzGBY
         5A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927076; x=1781531876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8slye6QO3nIlTUvISIckvPExDxw2ajmT7nTGEplbdoQ=;
        b=mxkomfqhFi4EI+VX+713VyfY7hL0JavpiSsZ+e46JHLmaA/o5mnabEL4Cn/t0Q0zjj
         nCJrh5iOL5cruZjZah6P5aeIU/F8lIaykVL5h5bYbz9Lm7a3XGKIJe6sNR3s7mpItu6w
         axwsWuouT35KL4IwNPFHFMq/6d92D/2nfHKl8staNSIDXmk5FdjS/LBQH4Pd8gRrjjIH
         0hjz+rv/d8IPeX3LIhTre1XWKV+Bdu6D0cs39y23aMLee7efO09VgndGYGOK7b+WZWQp
         Y0sMT6l444TTeGxP2BpsZH1ovuOQv2churSlkKsz7fgN/D2mjmt90M5DYeZWhlZ8PyTI
         3jUw==
X-Forwarded-Encrypted: i=1; AFNElJ89OLSPG9GVl+I9uSS6FdbNQ4ucdvL6+q+DeugHBchpVjFYFecbaVe6tS5W3OtwsTFzcn83hotOQ54=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrzlgw9onIJSTecLPOOC+3Z5Ee5f0urBAvFuBtdMT3hUf0Oxce
	vTq1OrELBm70W15F6Q6Z5PMVhRChdzEAmOzt7wVoIbU8cnt5bDewj4/Y
X-Gm-Gg: Acq92OHI8fj6tukw0dCCDm7madL72W4QPoF5a9GY5kIZN96O1lROSovK8/k8+mKgD7f
	/MAsBr5U9PBEPSrM+yIeL6rbMdodQXOBoEJhZRw0aQwEK6xcRPfStmDNUl0Y/XuhO86EHhcTGMP
	PMLzUk0so4ee1aRw0OMct1hXLW1vm2YAIj1tFsxs1YJEbKE3VjenOuMgHUb4+TSPhbyNQCavpm1
	Q8UyL43CrZN54clxVy8tkoVTN9hIiPRPUVV7qQxGb2/UNqhKkexv1OaIy29np/nWejuAWZa6F/r
	LW282TeHio94xzVBHD8Rn+Nf+oXVwgex3+a4Dwq2qAOpvAhkxupG9PQK7uApkZJQP5WsKw4bEJ2
	EpxOgS8lCyDr2Fo56W6B/yxbPBA8BAG5YHRf9POk/OV7nNJj3uyNDOYs0aJoK71AjKuQsJZd2s5
	0iae00kdXF29y5OoOLpNO3BKl2BAbvwrKOVWqSqcJlXgrqmsd00GHsAUUjU9XLFBw=
X-Received: by 2002:a05:6820:4dce:b0:69e:3e2a:a838 with SMTP id 006d021491bc7-69e68c973b8mr8217811eaf.52.1780927075839;
        Mon, 08 Jun 2026 06:57:55 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46450223sm10178767eaf.14.2026.06.08.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:57:55 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:57:54 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "open list:PNI RM3100 IIO DRIVER"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 tduszyns@gmail.com
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
Message-ID: <20260608085754.32def4cd@linuxescape>
In-Reply-To: <agAvydze87mMLaVC@ashevche-desk.local>
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
	<agAvydze87mMLaVC@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

On Sun, 10 May 2026 10:12:09 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, May 09, 2026 at 07:14:35PM -0500, Maxwell Doose wrote:
> 
> If email is not bouncing, let give him time to response. If there is no
> response in a reasonable time (usually up to month in the summer time
> due to people usually have long vacations), then we can act accordingly.
> 

It's been about a month now with no response. I believe it may be time
to make a decision about who becomes the new maintainers of his
drivers.

-- 
best regards,
max
