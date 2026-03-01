Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC663254B0;
	Sun,  1 Mar 2026 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772372490; cv=none; b=tEIcRC6CtJQYWUk55iyBXjBsMrPz/6hh9rDNEB/QBpmKE0jB1zPO3m//0D25gDn1sf/pwALc7NgLoDChp8m72ukmQnkgfTCpJrWsstc6Sfd+8MZMYgXWoEdcZ1nYM5E7v3S79CBvrkXxqcuWvbICJHeEmmhSjScwdftv+BYG/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772372490; c=relaxed/simple;
	bh=EpqZVzKWdEsIkiPzJLsZ2dOR2VUf0GLN3zoNLCZ07I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt9ZoJzdfF5XOKzipYXUDKQJUHexICx6QHt8qSxyC1vxkdIYHiYewrTNJQo6iqyG3QcmJzX9a/FD6k6jIAEJ2YAw8VW97FfFnQnK9bmHb7iV3U3LnB9lTV3mz6UUn17afzcES4XqDiUWfv9+pCclu+aQ4jEY7utGVw7T+fD1kfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRjKGUAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRjKGUAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FB6C116C6;
	Sun,  1 Mar 2026 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772372490;
	bh=EpqZVzKWdEsIkiPzJLsZ2dOR2VUf0GLN3zoNLCZ07I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRjKGUAOwBXUw/Q4rIXTMJTFpyf/hELE745qa8J8eJbLJubMPF+dzDZ2/lHjLk7LC
	 4G4E9qEnfWW1NNbiShcur5+UphomtkhaTGlSeLbrjZtaQ+vG4PH4GXBYLMONfctJw2
	 V1fl1huk3bBdVGzaSf7H8dLFsuo2hojF20kKyu5VGD3Iu3l8TSWF8nTsByaEKcAa0g
	 L7xmfGmmgSKIVpIJj4ZX39j7yzS5dv3ttvEHg0fZsbFgkTGxcNOljeNz1yp52prbse
	 Rl6IlZ1x3C65VAtItkhlSsR3Rdx++DhswtBd+xb+sebjCLba53bJ/wZr6YSlkeo0aX
	 zr77y5F+pohQw==
Date: Sun, 1 Mar 2026 13:41:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: aspeed: clear reference voltage bits
 before configuring vref
Message-ID: <20260301134120.38ae5ae0@jic23-huawei>
In-Reply-To: <aQCXm_rvwpB6-UUq@smile.fi.intel.com>
References: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
	<aQCXm_rvwpB6-UUq@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 12:14:51 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 28, 2025 at 01:41:02PM +0800, Billy Tsai wrote:
> > Ensures the reference voltage bits are cleared in the ADC engine
> > control register before configuring the voltage reference. This
> > avoids potential misconfigurations caused by residual bits.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---  
> 
> It's a v2 and here a changelog is missing.
> No need to resend, just reply with a missing piece.
> 

Billy. This one is still outstanding.

I was rather expecting a fixes tag as well.
I'm going to mark it as changes requested in patchwork and stop
tracking it. Hence please send a v3 addressing Andy's comment
and either add a fixes tag or say why one isn't appropriate.


Thanks,

Jonathan
