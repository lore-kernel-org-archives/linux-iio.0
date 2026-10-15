Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72235625E1
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095895; cv=none; b=f9ptoxZ1F7Eqcp0fYLzqOoo0+ZnA4v7zoOMZSwnypkNq0ni7ot28U9Dgu0GdoDebc28TVaOCg/iqJ3rCENBIj3NZpBqbvm5ZpFjt/xtOUoVlJW28ivkTQkDeBeRO2pcLkvdyqM037FAD3/iOwU/QHf8JMRpwehLzLcpN/G/qDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095895; c=relaxed/simple;
	bh=E71L1r583epiGUTv1SMWPzGa6IAmoxyuFJRZbVNZfP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgvhhiJgJ1Tq1/R3ssyw5bBpTDrMONaXPCf6JgNU9xCpHCYhwUn4asrBWpLIa74AIij8zIsp25rHOAeI2t2zqBS3atO8ot7RRrUnXbHM0mK9WVDhCjd5dZ7MN957Mam3Jz9A7dnM2jYEljPeAEZ/GW1V4dAmNxxZcDVhhfOctf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pn6RUwTL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn6RUwTL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so50966785e9.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095892; x=1792700692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeWT2hX5i0RVc/hkdeOUQc4khPfP5Wkpi27fPy7Q4sY=;
        b=pn6RUwTL6M48Q9BYkHn5C9/5cjscsxba9uDZUnbAlQovDAD/qYbzYKq8gin0Nl0LXH
         bqFKLzC1CF8g+3NPCzFEs036PYlbk/8Y0Dg8MHvsii7Y0suwNF4Us8tLvBJICiDHBJBc
         mSZBGZvIqQg1f4lwpzpoF7R3eIHINTteOVirST3Peo1K1uqsB/NEv0KdvWXimmYdALYB
         iniUWe4Fo2VssWsJrnagZjqmy59v1nHeYQ89zhIh/VhDWIHvqfiFOuEGBWySrWGXTG41
         zVpA7LsJ8fEX5PVoSQQzNXjM42mQfqnk9CZNGTJACsdQ+B7BKLPILjpeK/8QMSOcLpdH
         7vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095892; x=1792700692;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeWT2hX5i0RVc/hkdeOUQc4khPfP5Wkpi27fPy7Q4sY=;
        b=JjEqyiF8PvIvlpRSHm/NIx/3xaUmw/+Z4IYJk6lCrogtkuuXwvIhPtDBmsAUtW+kqu
         WS87DwF+S9Bo4AEFM4SrrqFzLUVaWyLp+u2Drats/FaGqGK2pfo60nLPhTmOERuP3dVX
         q+ymJFe5az4iWRhvubwHhUnqnG/TaHdArhj64V/h28LFLrIupdwuXw2eZRe+efapR5IF
         bF11bQzaiY9CjKqEvg4p10mLoWpYz6190RUoltz1q2KGbWAZHj3h2wDWk/FToJffFLX6
         C6b5tZSw2VZatqiCBBgpAozCSfvI4u8zY2oPPPWj64jzHu+vdWzeURvfc7E8G8UhFlqV
         ixKA==
X-Forwarded-Encrypted: i=1; AKwUvBxjF+daSqCwQU9XzI1wmBU4BRaBmexIVMMMAj4b774U9N+hilBViR1JHEExOo7SCQ6Xudpsox5bTdM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdal6FGBayv2kweHZ6EPwG+A+jYPeghotTRKuNXH2+PKdUcpWJ
	QKrIkt63yJs6q3tj33vinK+FD6mEIiWaqmhZ+a3cQCENaLICnCf0dDgH
X-Gm-Gg: AYBFou2m+GojIT3qBJ63nwya5aqx02KOU9Xp4WXA4DUyZME3w7Iu8LzJdTsjpXB9g/Z
	RJyd23Xp0UY+Sz7N1oMS8S/c2A4sfHaub6Y++FHZms9YhxHFQZRRt1wa314pN0etD5UEs1dYW5o
	HR/3/AudmAwvTO/xLsvjYuImd83/KMlkaC88drHhcOxxd8E1M/LCX6Da5zLykUOK91FQRO9h2OG
	Z871n4n/ZzeGMPoZoLUbOAnyMtZWm4DjLDlV1tPMyIHO7wyGLmsQT7M8QD3rPcA0mZwiNZ3StW7
	HHVpaZLak3jGzhesfqEaOpdJi2XG45/f/eOe9SI7hJr94qxquowDgrKr0shR2z4MJBeDFaMyNPy
	34UtZIqjAObgRYeOd4a30u1I6XGZXeM07bSZEJAdJE9iqfs4LkGO+19ZRQSAUibkYgjdgTaXz14
	yPS+s24osAj1JWd9fjRYN4wnCC1lF6ZTs0Njz65dJz4hnYCdPCkB07NRwpNWi4aEtuBdh6ROJ6M
	Y5wn3XZyJRnDAgvJEF4f9Dq3oxj5WsRVGy3no/a752nbF83Y60LOLGGwt06kqRcrc1kz4R4u9Rq
	trNfzLtUeuRIQOnLAO7lMAXyAoitlkNqnieS3qkpah6nq4woqyXpifRDkahMNI9Q/rzbB6LvDUy
	Jsp4pbvHQVz2bGrDQbSbJ+igCZoGKpTLfWqj18KkUMg==
X-Received: by 2002:a05:600c:8b58:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-4a18e4ca287mr378920735e9.24.1792095892026;
        Thu, 15 Oct 2026 13:24:52 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ac19c9sm2096355e9.0.2026.10.15.13.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:24:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:24:49 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Zixin Wang <ywp1023456@foxmail.com>, Kevin Tsai
 <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3] iio: light: cm32181: add support for the CM32183
Message-ID: <20261015222449.5fb400c1@systembl0wer>
In-Reply-To: <as6gvHhkgiudzDz4@ashevche-desk.local>
References: <tencent_850445458D21608E9C8821E6728457F31C0A@qq.com>
	<as6gvHhkgiudzDz4@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 00:21:00 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 13, 2026 at 11:07:30PM +0800, Zixin Wang wrote:
> > From: Zixin Wang <ywp1023456@foxmail.com>
> > Date: Sun, 11 Oct 2026 08:29:13 +0000
> > Subject: [PATCH v3] iio: light: cm32181: add support for the CM32183
> > 
> > Add the device ID for the CM32183. The device has the same register
> > layout as the CM32181. Found on the H3C MegaBook 14.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> However I dunno if the above email tags will be handled correctly by the tools
> (usually we don't have double Date and Subject email headers).
> 

I checked just in case and b4 ignores these and applies the patch
successfully (while retaining your Rb tag).

-- 
Kind regards,
Joshua Crofts
