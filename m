Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928924679C;
	Sat, 17 Oct 2026 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275473; cv=none; b=nc7amzzp2Da+yIXxETjzjJAtbQbc8kgCScNKm+ilw342znBwO7UuAEhlkGtnjSrO/aeDbDzwz6zzXYu5MqsYWgvyd0ccQkoxKF/URtF8cYXx9IGS2pREg5o1VfTZCcpk7qZTYsV7c7GKMf1PA7G5xbbhQeXfZ7JYipNOJLkvJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275473; c=relaxed/simple;
	bh=GVvKIdxA3lajPWKOr5p0o5DA/qEDugBIL7t9cPDRfAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amu2IGqYa8KLjkWonkfvLotlPdodeIoQV42Mw1iIuD38YNCNpUE0TORk6ZBfYJIyqDQdhPqN95+W2Mm3w7/dRwFG6JgTntfbn/kInMMxxNMj7zr+54iS1EU5Ysm/9orqrXTOFXObeY8wbttjmOe5VlOwua3Rg3K4CslhaIl4vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGeILFWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGeILFWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D870F1F000C4;
	Sat, 17 Oct 2026 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792275472;
	bh=egKToc/UNv3qr3Z0vgPdgL/582QcdlBGijcSfMHx/jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bGeILFWF55flSfy76WkvILYcGPdNu6nALfK0j3EN5HYib7Zi6JvHd6u53d5vE08pu
	 9gESc035vt9CaYBR/U1Rpg2fbsfVuShICpL8yKzSyIJemwE+4+jU1z6adPzdoSV9uG
	 fnelCmzgKBPGwrFY+8oG9U7Pk2Zh9gmWTa9GzFA/2ICUDqbbttPX+Gyh68IKbyRH+E
	 DwUp7GIdRe4uNqpiFI+lpOW7qTaFaRMNkWWQhdaVarebiCjkGMgCfCLPxMnfWAUYTN
	 SYcUQ/WvTt9MH/eampJuyo++ZTreQ1dYhSsDyQHUZQu1X24/JfvSkHK9fvx32qyOkD
	 bHJLdHdO5EwVA==
Date: Sat, 17 Oct 2026 23:17:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <20261017231747.4906975c@jic23-hlaptop>
In-Reply-To: <20261014091111.20059-1-abdelnasserhussein11@gmail.com>
References: <20261014091111.20059-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 12:11:11 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Replace manual character checks (e.g., buf[0] == '1') with the standard
> kstrtobool() API in sysfs store functions.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Work on this driver always feels like we are dancing around a complete
mess.  The thing needs radical modifications so most likely changes
like this are to code that will go away.

Still that doesn't mean small changes aren't going to help whoever
does that work read the driver more easily.

This looks fine to me, but given the potential issue with Josh's tag
I'll leave it until that is addressed.  Perhaps I just missed an email!

Jonathan



