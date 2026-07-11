Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30B2DC321;
	Sat, 11 Jul 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771946; cv=none; b=WkLakRJSW5uNqxXv2QrQOyL8pxoukoqB7rfuz1N/PBqTNngawwdD2qKZCgYk5PfFhTfZkApwz2EAMW6Y0a+H7/WtUlgRSHfOX4axT6BNXSjqwCgUtsQW6r11u7p8pDhdxaAUDyXvRX4cwG34j5U+r8fO3NT5p2Y6uOChNbPN9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771946; c=relaxed/simple;
	bh=TvY6hiDBwaVngLDRHNwubxxZBiyYRDCgIzS8GoPCsYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UylEViFK1+3vdQVbknPv8WIW0vq5aX0DkKg7etEvwXMLVnWz8L4lIhCBGLGd6iUtYDg3sHlMSISX3N7a7ek8ld5OcJ8ETXJsyaYa5WurjIv36MVGmPjz47pKcFIzbG8gk/LnOvTmPeIgibnWBjsKao9F/I91yj17+8z3R9BlROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUrA8jNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUrA8jNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059281F000E9;
	Sat, 11 Jul 2026 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771945;
	bh=TvY6hiDBwaVngLDRHNwubxxZBiyYRDCgIzS8GoPCsYk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=FUrA8jNzqq05JZBRWDsflplQdXCMP4DzuUFmIgshpFuOkF1/PqCcxtaAWgt7T2Q+9
	 dRj/fVk4JdBIh9sgL1P8lhVinh3A+D0UAjb0z8fTV2/DHQwJMd0TaYk05f1Au1Avee
	 WV/NgzQa5d/9OjTiFKbmmRtc9//8OGsIAwNLv3AM3moS/4bNcvPp7dQnnMHQUBWWeV
	 5ZVOnfcyAIBPehdlDQ2finZGESG0laHdiP1h03xjBKMtNvUC7Ng/kSM8wQ4UkzwU8y
	 zVHyGbLIBkXZsiDENupOru4eTGhTComomp94RnWeyDMXZzO9X+ZfigJrdDK0o0mJFO
	 eBcGX0/5zQAxA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 14:12:21 +0200
Message-Id: <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
Subject: Re: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
Cc: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <andi.shyti@kernel.org>, <wsa+renesas@sang-engineering.com>,
 <ojeda@kernel.org>, <igor.korotin@linux.dev>, <branstj@gmail.com>
To: "Muchamad Coirul Anwar" <muchamadcoirulanwar@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-3-muchamadcoirulanwar@gmail.com>
In-Reply-To: <20260707151542.91997-3-muchamadcoirulanwar@gmail.com>

On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:
> Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:

Does IIO's iio_device_unregister() synchronize against in-flight IOCTLs?
