Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8C2874E1
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584704; cv=none; b=pYRzN6zUfRp8G3Oows+jDj53akaPuvRxVhopfi0pfpU+GAAf59JzNRiviSWb+I0xdc1vNVqqKQV0dq1kJquteO5fBs6bIt5mXAY/fb2NL6rDyrtle9+VfB+J+D1Yd9B+6wFMgjVUUUNmIwKjo6Sj7oaNHm0xhdNyMFARYAxbQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584704; c=relaxed/simple;
	bh=hnpvJsz/7NHtm8D9D9y9k/IUng24TAcCRnKt7CWPmYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb834+n2lG7FQ63mrsyyaUkVtn9++HMYdCct7bYA0o9aV9q0i33/JGyCJY2AJlAlWYpDiDxWmbTSxE0zbKVq8VIVJZRrGHU8bDu3B4T8W86lUtBcWJOd5t+QAm4tk68y5QLjaQAyWa2ew7Wzr+Ev3KL4WKuS4a+zmf9Bd+jeSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjv1gI1u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPBvcaIW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjv1gI1u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPBvcaIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qawkN3DtVE111mzIt5KPEyGsi5BA44vNguHUvEZlhL4=;
	b=cjv1gI1uXtHjVEhkc6HehgsPs1v7YJ0XEdF3HHm2h+Ty2FQ3WYbuBryrGJlhx/kOh5dreD
	y4URYv8HoMoBJl4U+RW4kn5n52hZaAj9MrMrOR/P2uxwJ1TDae7yal9ny9l/YxqidtTLbf
	65w1U7iOCPH6d41vtNItfz1Yv/N1Kp4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Xa5J_LQJP9mId-1ZFubvAA-1; Mon, 24 Aug 2026 11:18:15 -0400
X-MC-Unique: Xa5J_LQJP9mId-1ZFubvAA-1
X-Mimecast-MFC-AGG-ID: Xa5J_LQJP9mId-1ZFubvAA_1787584695
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e820609d9so387258785a.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787584695; x=1788189495; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qawkN3DtVE111mzIt5KPEyGsi5BA44vNguHUvEZlhL4=;
        b=RPBvcaIWbmn15HUiMR1Cq9rdfgl/IUzcaKALN52ufXx+DAJ/skNLZqHDKMJJZOxTkg
         WGrsrH7n+Vmpbtz5uKFCAW1Dh92pGSYtZflNzuQiI+5U6A7eQgw5HvXBH/csLRYy2Oay
         8qfp1X4TQXTKvXdqVgTZ37JNahJYQtBkjNs3ujVb8QUoz/CVwrpTTeKOd+Ezl+yZcPz/
         wRkS2EIduZKSBZzG8lZb3Oypq0tCEIf27iwHeONW9KcXGsMHIORdIHi3Dh69LEz4r2+c
         3lP/DPpDnAj3KFFSwfYeZ3/VRVfTRinaCEaHUJXPjWzmMXXcvRMhnVM/fZjkW+KPP4wo
         0Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584695; x=1788189495;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qawkN3DtVE111mzIt5KPEyGsi5BA44vNguHUvEZlhL4=;
        b=EzvD3wdd5GO2Knwq/iYonhD3ghu2WnD4OlPNAW2jVVyHO+jdY+mQ/U2/FTRfGipF/9
         kARJgI3Cn+scH+bvXpJ0ygaREbH7G3LV7kn1mjb/ha8SwYPNAzYh/6TeWvqHuxQ6I2wd
         attwto4zghjcc9LAvm4HOb2tCyQkRURlK2spXt5L3nzHhNgDj1fDA9ywd9BrvzNOxguF
         GkjDQbvIw5D1xgxS1F05JXbOcybPO5vV5bWnAbTGdVxeyxjXDsnOiJn2JxaC//l0613v
         FcUf7gfZkLPKqCLPFgI+Rwz6vmzwE7ValfPNrTi/L0zFMjSONhL1ZsncnfvTugDTWZ5U
         RIKA==
X-Forwarded-Encrypted: i=1; AHgh+RpIH1bURDLAm093q54XepZ9A+jvA3aAR4PVUz8HfiaEo3Ge0YJm2RdnFwgkCBUHCjrXqYMZX+uLT/w=@vger.kernel.org
X-Gm-Message-State: AFuF++k6yfj2Rp4lsBwc2XnY2Bpb0QQ9xD2JWGIXWmuhpLv5WCs9ljz9
	7DrX1FHJ5RV8LAhTd1rVQwz2yGrkZbneFZ3ddjG3FZEfG6y6oJpBJAqcbOEQlgCMITwaxV6EM6g
	j9h1h92ynjDWUNxJ3hGxGDP9+ouHDav2xrEjqugRl2ntD+JDWKqRKgkiS+UrJdA==
X-Gm-Gg: AR+sD11MthRUO7semy0susG55AdLoQEajeLW/gV5SFU0m78NkornfoWi6Keq2LVZ6ct
	MD2DzNQu3h8PnDlimWW2NOQct/q8WCEvK0KN+Bxg9O2X22gDKY2sbpOg9J1LqjmtumOGLHBmR6d
	siisrWerYoJx8MnG3L0WVmAUwJquw6mcluLo+BGz0n6xMm7Anxy5rMBYevCtnRb4gr38EXXnJcz
	Os9TMOXkBGjxptQvV+n0Ap2Pka/tLAJVJKk/eQmKRPA+6xPaInvM89xvFWpPqaxjjM3skTuzQQZ
	OANU6bXVv/KOwPsjgQK8qtptMCij+wlz/dWKwwdAQVNqHNtJ0IjkN6pQGEc10b3um7c3gxgZJ6U
	0gK5yUehIxV81SH8S9E3kFAt5prhBJfB1nxM=
X-Received: by 2002:a05:620a:1b84:b0:91d:6ac3:565a with SMTP id af79cd13be357-93739496be1mr2647806785a.12.1787584695056;
        Mon, 24 Aug 2026 08:18:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1b84:b0:91d:6ac3:565a with SMTP id af79cd13be357-93739496be1mr2647798285a.12.1787584694575;
        Mon, 24 Aug 2026 08:18:14 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749af9384sm521343385a.20.2026.08.24.08.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:18:14 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:18:12 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux@analog.com,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: Make sure clk_init_data is fully initialized
Message-ID: <aoxgtOxgUh7CdzNy@redhat.com>
References: <cover.1787240005.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787240005.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Fri, Aug 21, 2026 at 12:04:05PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Hence this series aims to make sure all members are fully initialized,
> to avoid such bugs, and to prevent future breakage when converting
> drivers to a different method for specifying the parents.
> 
> Part One[1] fixed all cases that I identified to be real bugs, in
> response to a crash I saw on BeagleBone Black.
> 
> This series is the IIO subpart of Part Two, which fixes remaining cases
> that are currently harmless.  These are still fragile, and may cause
> future breakage when converting drivers to a different method for
> specifying the parents.

For the series:

Reviewed-by: Brian Masney <bmasney@redhat.com>

I see it was already picked up, and no need to add my tag unless you
wanted to. Just providing an OK from the clk side.

