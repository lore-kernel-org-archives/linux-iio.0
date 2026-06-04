Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E583845D9;
	Thu,  4 Jun 2026 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562687; cv=none; b=mfnwEPPzW6DDtSPAPKKVlBaF2XSxk256LlX/bdjPMRCA7J2mmLAMdsHl62caAoIaH07Y6J07OUJ92oHdTQe2o4Wly9twJ18jD/AwlW42SkyVWPjvgjDx1oMDy11ncNR+jv7HAQ/FppfEEdWR1HZ/hzqc1Ku4TWtLSYgOrPFY2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562687; c=relaxed/simple;
	bh=0yOWO35rcDsarFlXpNl+Ju0O96SbL2oqYWhyd0MnAVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnH4Gp6NDBUNkfbNQhdtIlHSJC0s9dZ/JuPsXv+hPS/2nuqLYZ1FGqXA1PR4UIUOBHe5ABkjDFy2flxVEn/E100Z7MTVvp0b9QNZ5eUiKeK8SVR6m1S/1hbwFrKgFHp9N1SoHY8nItT/11c5akRgWMf0Pu59phfivoMGRoBee1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNbrsH9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNbrsH9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF491F00893;
	Thu,  4 Jun 2026 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562685;
	bh=R981tlrK0klQUlTE1sFXhwd45Yh9urS5lTzUcq9Q9TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JNbrsH9WWBgUrtly2yt3++Zhh7yjb2XvTsO39Jjl7Jolygo7ww+7joUCCB9eNzCyR
	 3cbzf6FNVBTYmnGI4w5V/pK1c3H17bZcy6kh25CJxRVTOX1qS0UuBCnG8M1xCxdDce
	 4Oqo4azMyXtbKMB389Eg9rbT9jILkPEJdK6yehDuW3/KpdDrbVPCgnGlG6+Rmw8JGh
	 T8qXBHJH7bfuYz1fMB8hsjh/jXPP4ILJORsmLex59E4do1/862m9HZNcp0KRd4ky9x
	 Tyo1R1OYhDhSoKrW2rPK+NjAbAk5amqnlr+Re7xBme4k16/rk318ijsDsc9Buvy5la
	 i5uCmB8vYExIQ==
Date: Thu, 4 Jun 2026 09:44:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <20260604094436.3c50f123@jic23-huawei>
In-Reply-To: <20260602-slf3s-v3-reply-03-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-2-wafgo01@gmail.com>
	<ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64>
	<20260601104233.310ac930@jic23-huawei>
	<20260602-slf3s-v3-reply-03-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 16:08:33 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> On Mon, 1 Jun 2026 10:42:33 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > I don't think that discussion ever finished. [...]  
> 
> So i need to decide the unit: l/s or m^3/s? My feeling is l/s. The ranges
> are sub-ml/s, so m^3/s only makes the scale 1e3 smaller and the DECIMAL64
> precision thing worse, for no real benefit in sysfs. If you want strict
> SI i change it. What you prefer?
> 
Yes, I'd prefer that for consistency (m^3/sec).  Hopefully the scaling is fine
with the new forms that are happy with more leading zeros.

> Wadim

