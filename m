Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D1542AD9F
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175129; cv=none; b=kwQ0QCWggIHXP4KwEh36ZpZRaowQ124N40ywo2myk3lGsg003nuVT6C/nOln5wPw0av8O326jQdqUSnzjqj/VNDnCkIjc/BcvA3Fy9wweblskOQg59QVSJr44d5RTL21yxkcUkVdrhu/WnLQsuxpvEG7QlrcXz5WhDX/1myMf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175129; c=relaxed/simple;
	bh=uDGg55LD46cTFdPoXEOdJ2MR484iJBAu2IBTGxWegTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gC8WhGMx3HbAEbO6zCskZDjQ3PFD45Euv5ASwxZiu2nxqCNbRC1WzcxfNplE4JmAaLviUu3nDk56L88ZDycnznaU5QGnAbePZ+e/t/CeCPSsGQFV98ZOsVX8VbXwz8AZPyA8RUFB1Umnl+jjJf7SAfdXYqw5eCnaCZteN8P8MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVG64ARv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVG64ARv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso8631885e9.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175126; x=1792779926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GK9YWjb0YESC/KuQ90FSzRiNg/DjXyJN/7JSahcZ0z4=;
        b=kVG64ARvibBMP1oOz8cj2LxhfmYc90EKEWQp364daS8Tus0Vqxn1aN/rKxPz8O/7jQ
         zgnzf5eZh39gkX+CuhGxIJmPqtZvv2yQHCIg5IOVQ7iWjuAJXGg4epkPcJFyLbVa1cbq
         VZJGSWApsMGxMnXzpK0G0O9CbWyFqXuWsWeHY+HW+Y7aymNz580d7yRRNTNGrMiYE24g
         M3ACg9Bv8ja/CRGwdjWfZmqekJRm+rd/d8b3S6Hr6x2pOAkQ08Euvb9aI1FWM6xXtWyi
         rXK7I6aTmLFHKo1/YqGZJbSMrPwtWppHUFJqLIeBf+6g2psKC7y8lZAb8MZLldV7VzxT
         FjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175126; x=1792779926;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GK9YWjb0YESC/KuQ90FSzRiNg/DjXyJN/7JSahcZ0z4=;
        b=VaXI1uVa2kDLzvGVlPqfO55i0yaZ6g5+4S9LCQ+RRoxhrskBNo8SYZaIvXcOHad6uI
         zk6kJsPxyVkgI2r7Ln+StCFtPhkNh5qoqb8JZO9wDODlY8BC0p3uaikNQeqmBDXG6PRt
         VwzYLL01mOWNBzkPvpoX1yiRn09Jf20sZ2BYv8OWGeAQnhaDlpgqtA192iRihOTXnnlF
         tNQ3Z9v0TauweLcH5ivRLCziZ65xn/gSbek/wYsZ2NvZ1Q36Ot1YCe+nmIo33JzPhbrV
         V9CCNVVuekbe2UjsXnolJLwmrQ+Wip995XohCN82/2f8EBk2l2DsjnjwYoepeDcDgGsI
         n96w==
X-Forwarded-Encrypted: i=1; AKwUvBzDZ49FroxxYx89snKuKvEpgPB5Ev4CvDTzHyjzd54V+9FlvHnms3ZGiS3cIJdusuFBWakg+BggqtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGAId/L2veObk81AHqhOAB38vnQ+FBDa7HdU1wyMmzbNqiqX/q
	xB0l+XXwVNoYn0h9FZpDl86ldizaSAsnj8eES0lsOQiGM5fGljEjqYu5
X-Gm-Gg: AYBFou0vcEH0YE0wsJeC2yCpGPzS2zqd7E2861TTzeBlPvvGQgIYIbLypD1rTbPssNh
	4M/H2zA231Lyhn4qUimAQmcZLVY/FCFYZJQTVoFAmzzkfuxAfhrEBMI63cNese9qpd3tCKAnpBf
	hbaX04kkynkgwjkWlOxO2EaxC5QVpYZv4CALyWzeJ6OLw6DxreQFGoEnIlTjz3OApDAOTCzoAtm
	YiAC5ADj8t+6X4Masa9i8ZHgwUe0F1wUsl4wso7jwxq2HmSsUGmjmBQpLkJYOCng3zWMJJBPKow
	TGe5R6HFHC3mlxV301TLk3AlllqDEeU3cp3l9+3yq9GfaZYbOcyE+H9197HlIhVjoRW/rAFs9R+
	j13b9ZCvI4vMctYAAFEyVJpJlur8D23RAkIwmuvO6WLhxnw+r3NusLXd5Dmf8qibRDV/epedyUc
	N6Pydk1BkUacnQiJJMPivqb9S261vG32k4cwCCoJTzj0Ax1aEcRSRRBWro+LJJXseVwGQRr+usN
	nRBlXWWOnCjVOFfbnHp8RZDeu71oHNTK+HI2KJt0HiZVtlE51PtWGztrR2vTSUGQLeB4Qp3u8Pc
	SvCnkJGWaKajnUp4+wcI9A+TK0fdyU5L0kF2nn6DXn6dZlsBCEiI/0rVwLULwdVKvLL9klPyTOV
	EAatGzL39WaMTuBbx/rOChK545cnYGao=
X-Received: by 2002:a05:600c:3f0d:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4a1d75fe72dmr14360435e9.10.1792175126161;
        Fri, 16 Oct 2026 11:25:26 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm77507835e9.6.2026.10.16.11.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:25:26 -0700 (PDT)
Date: Fri, 16 Oct 2026 20:25:24 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: Allocate trigger before
 requesting IRQ
Message-ID: <20261016202524.6193abcd@systembl0wer>
In-Reply-To: <20261016024735.3667060-1-mhun512@gmail.com>
References: <20261016024735.3667060-1-mhun512@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 22:47:35 -0400
Myeonghun Pak <mhun512@gmail.com> wrote:

> An IRQ handler that already read trigger_enabled can poll data->trig
> after buffer disable. Detaching the virtual IRQ does not join this
> physical IRQ, and trigger deselection can drop the consumer reference.
> Devres may then free the trigger before joining the handler.
> 
> Allocate the trigger before requesting the IRQ so devres joins the
> handler before dropping the allocation reference.
> 
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
> 
> Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
