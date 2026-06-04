Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D91403E82
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569738; cv=none; b=LMTbegfXGLtE4WEXqy7Sqx3/Xf+P3vSyhk0HYbzo8nqW5kM1FZHcAOmYwYwzkogNjoS4KEtTO9JU1xisJ3hC7zHVF/1nxc/4Vn/PgEBwvDk6bi98BCs1zyPBxercuLP3gfOkU3I1xH9F5gmeUXn1t5l/6sbdKtEJJq2ZPiFCOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569738; c=relaxed/simple;
	bh=xbcepqutzZlLnilfEksjMXSq1uOmhT80rGdIOtRA0pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfWYSh4wITPEwPPhaYcoCYk548qzn70uXT6AEP0BsmMqVCYplvlIXmWscRNI9D2JP+HlgitgcFKtvEdQ2W5PsFmF92Pp3qf6BI4g4wZwPf4DD1dcfK3abvsV6sevgMig8ZPHUq10t2niGIJfkrISVMMi5xIMG1pyb0w5Nb1lLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFSknZFm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFSknZFm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso284457f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780569735; x=1781174535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LmsHUCkINh84aTqk7R6AM7AcvSURHOWGdlfRqXt7/g=;
        b=QFSknZFmsHt08rzGixOflykYCvJeihGKIe8uQQp4iQtj5PI1AFya/I37FBQ86InzBp
         CSOi0GB7z35fl2y4Q0jEqhtnVb0AChY6tPVJL73o4sDaq6FMU93qReRu3d04+kutKGXQ
         1h2HT12uJ+noY8pR/yerNFWfsJd4r2+DDQXJ/bgoXT6UGH0WbogjXnBMmDdHpOY5noNb
         6Q8ZDPaszkPm+s+RmHvfYheNR5tBNObVrmbNrdjLWZ0HGgA7h9vc8vCDguhSwqa0k30k
         Ly8oaOX7HIvLXpIkg9540IJTXylWTJON9ml7gVWyka/8H00CyDagbWrCka/GJdNOLxZr
         Gt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569735; x=1781174535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LmsHUCkINh84aTqk7R6AM7AcvSURHOWGdlfRqXt7/g=;
        b=KN8Nhnd5L6F9gJ9MGAZudGxrJWP7b5GofuG0u+Z5k75WCYbYBLoG66bt3jvuiWIN6/
         SuKBvheKsytsvjwFvcfT+VipdOeseUSoLVNvZT/RmNglXv7CIdUYcjPSVsl6x+9WUyb1
         ZWZ9HC6mT7S5SWfloyU02NrG7RHc7Wdr1m7FVHzgDYG/cSWDJ7qjVEHD2whZNplt0xqj
         0uH9KY0bGqntc0dcq3KoeLF1D0cDV9Ll5C+3XeKe5oL9tgMLBEHnj+xvmQ713cVl2iOF
         IlCSzWLbq4sd7S0QmYirwlLRIXyA3idUxFffykT2HYyuFHXd9oYZaDtR1tABrpQmkCAo
         +8Xg==
X-Forwarded-Encrypted: i=1; AFNElJ+4WPT8PKFa8DJcvmFWfSbKI+0c2yRYNvLLAH9+KBAZSct7lPFw9XX/KytKAeGSvLTOrt8xUsxHgr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsu6EjAepz4q5ZTYI3J7OKnWL8xQ0q3Ptl5HBJYtFH/X2piITS
	330TZNcJGuRoAalZcm39JNI6Zh+Dfk8ZAa817UI7X6XhZ0TrSTGu6IIZ
X-Gm-Gg: Acq92OGqNasWDUJiG5sP8JESvIzffVAZ3ZrH5Kmzi1X0iNRJdfQps4lR8Kw2OlzE+on
	JXDoBsLOF8WP1rETP2sxWuUdUUsmKU2SOnu9jL07p/6rQC/OG6SVnhhowq3zJW2MQ9ViQr4usby
	wcIHVpWX0/KyilUSbZHv+B+b+cyihP/X7maa1y1Ae0T70mdA5oM+ttshO9wxXLpnr90kvGhIQBR
	uQ7bUKUM4IavvR4xD/Lr4MMpPr90BeifxVf/ffgqIZIPIJPikBaMnNqVB7+stwe4heJoyQ+lUL4
	6/HzPBKt/4Pvn/EMqyxZD7ljvDRRNQzWiK4ww+SI2H+yum2VsUfyelk/PFbz9iOOiq6Q6LMNvK2
	2OhvQlCpLa0WCg/Hb/c3bcggiuDMuf9poQOVSS7Cy4oilkNDVgxVYZAoHOFfmvcKw5iU3fiehuj
	gvWZD3426cOBBV1hAcrXa2vTZQLJ0IhA==
X-Received: by 2002:a05:6000:2993:10b0:448:7049:a6c9 with SMTP id ffacd0b85a97d-460217800ddmr8692539f8f.5.1780569735217;
        Thu, 04 Jun 2026 03:42:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm14871477f8f.8.2026.06.04.03.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:42:14 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:42:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiFWg6vC2cVbONTK@stanley.mountain>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFVuvVtaWbjfVzA@stanley.mountain>

On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
>    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
>                              ^^^
> Uninitialized variable.

s/variable/data/.

regards,
dan carpenter

