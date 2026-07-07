Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E631A08AF
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390656; cv=none; b=GVUU5oXPIuOYxr6s/66s5neaLKb/oBCXPtxJr3mPGpULae0D1X0r70WFcPZ5bJE65HJW/9JCNra5fktiyYlxz/z5noUAB2/KI0v88pdSvddWjFh2g/cy2EkxvytIoxbP0uI74ubgkAxWn4ZeWqaMzHr495O0X5uToDfckxmA/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390656; c=relaxed/simple;
	bh=HnzjIPigp5YlbXhzec/OSoyFHt+Et8hPiNo9X50iG+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA+gK2I0g69+kmCJ8niwxc0AH5CTp+32jOQ3PCkV+oGSnP3ngksdN3ioxsXS5JxUV48lqNK9XB1CR89WteXHzUsB6I68oYw2fS/MFIKbw7b2CVq9JOuOrv58ne6Ki07Tm0EIZaQLNzfiHfGgAe0ryCSbDzG3ByIlXXfrpCOXh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkOBg7dR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkOBg7dR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9341F000E9;
	Tue,  7 Jul 2026 02:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783390655;
	bh=yKTJuEYoIPIC/8v3gbbAO4sDYxiRckBQiIajkE5r/+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JkOBg7dRWWjjkSNJmlcRPKoZQ7wJjW9L/Vk6YgFbEn7cpKXVSjSJsGhjqOJxyivjf
	 8jU0q6WpK8pG9rDtP9mPH6H4dmuyE0b7XWhXapP8fkAM2c2yQ89Pq0kWIKg52ghXvf
	 CoUd0jM8lLLNtAWgeMoKIatr+UoSdWTiqwkW0+sJMt2ziaGjSXrQaDi/O9ICKZWnbR
	 g0GhZj/ilM7W52PPDGWSRkld8xk2ukk6INUYnZDYm/kYZnoYLVOnsiAPdgrKesMC9R
	 EcNT7AKNmv+LJsXgyQfWu5tl1tQ7XJgbNwthfMh/Geti4yPnj8uqFbAO7FtFAQ4/pm
	 YaaRRxt2SdSIg==
Date: Tue, 7 Jul 2026 03:17:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260707031731.0193f581@jic23-huawei>
In-Reply-To: <6a4c2e6c.e49deeb0.d08a9.bbaa@mx.google.com>
References: <20260706112254.1262002-1-shofiqtest@gmail.com>
	<20260706185041.0e31ec94@jic23-huawei>
	<6a4c2e6c.e49deeb0.d08a9.bbaa@mx.google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 06 Jul 2026 15:38:36 -0700 (PDT)
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Jonathan,
> 
> You are right, and I apologize. I sent v6 before working through your
> driver review, which wasted your time and the time of the other
> reviewers. That was a mistake on my part.
> 
> v7 is ready and addresses all feedback from your July 2 driver review:
> the driver has been rewritten to use the kfifo buffer pattern (like
> MAX30100/MAX30102), the IIO_TRIGGER dependency has been removed,
> register field macros have been renamed with the correct convention,
> IIO_DMA_MINALIGN and IIO_DECLARE_BUFFER_WITH_TS are used,
> regmap_noinc_read length is corrected, and the remaining style points
> (fsleep, NSEC_PER_MSEC, regmap_set/clear_bits, goto cleanup) are all
> addressed. The DT binding changes from your v5 review were already in v6.

v7 still has the separate patch for MAINTAINERS which has been called
out several times already.


> 
> I will send v7 shortly.
> 
> Md Shofiqul Islam
> 
> 

