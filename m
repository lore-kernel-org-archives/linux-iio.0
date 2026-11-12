Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524189;
	b=QdPBhvPLLCbJaIZhBtrSRM1d/74GPJYwfRafo74sKxLvdBbUn6GYJoOUbgQcBVNxo/W3
	 kw72NMeaLgW21oXUdX3W1DJYa8cBtbB3Rrik6q3NVrD9qEqRi0kdmRn+LvSq59/Pyy/ul
	 axPE2m/AwA4Wez5UEeXPqSmYdo7AGIrFWmT3DaslpBgimtlwcYvkUHMov5pRsKfeEDs8z
	 CSo3ilG7vzIsFI6wAHYTV+DhSYKS8TmSzWdVRKrnwUKTUDc99SSrScDsZ+2WePwBqypQY
	 rgjPsNT2CnuPNyziMAfYelbFZYwH0Neoq9DHGdU0MAHZhkWwQDhTY9LkT9qQnZFs9eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524189;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3LmFrsBQFbZEhx18usBDVPj20osM9FeVGPojC5J12gQ=;
	b=OpswdMuVYOMDVbp3t5KYapquPW4l57s1yMRbT3XiaiUqK8+0ce0oUWt8x+rifQPLfryx
	 tmCj6cFOXk3cbnJSTgCk9lurMF048xsier380nbLfKxmiWI/fGXqJe2IkwYqTQWOqFR+o
	 toWPmkbknWk/atcVRGbyDt65l37HdQ5m/YgEnw0mLDZLnpDXdt8lk+PuHeDhM2G5aqCjA
	 kL3pSyBUQjQK9srR5Xgnq8IszCqy+qrBpGJ/g8MhFNRMm5C4Y0UeTSAUPiCNT9sjPzHaF
	 M9C4t6M/fT1Gy6dQy9pDVBStFycrj+8dsAxz1qbcSpi6HLeL8wb6jGXnBEkG7frJdBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HllWrPif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64002606A880;
	Thu, 12 Nov 2026 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HllWrPif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BEB1F000C4;
	Thu, 12 Nov 2026 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524188;
	bh=3LmFrsBQFbZEhx18usBDVPj20osM9FeVGPojC5J12gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HllWrPifUSJqBkdjY9YrTJzDMsN5rQUpW6Vx4PfZBFkAsYhoO8HT33ivCvtOTCtuj
	 zvLdNe1lCLQwolmIiVhQ+NWBEI4pRdu6cmbrqxYsvFWAewlPa7jifPDtT4J3b1C6lG
	 7fbCQ9voHcbxeFjngoMH7O2XVRMufhTrVuBP0ZndRTP0zCWo1W9cwSreWiSUOHo3uz
	 M0v1ysihN0Yg44yNlZtCqZisx65YDM8kHbdwgcl3NPUWELg+HyYsFXeXNslX9kXnIx
	 vEQNyAauKKkf5+oPAUG0/IztXO8zJgoOAZPpCBupJ43ZRlkA9ccutBVy5ySGQGKDCm
	 qedFueBi7YI2A==
Date: Thu, 12 Nov 2026 16:56:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: andy@kernel.org, krzk+dt@kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, crofts@kernel.org,
	alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, akhilesh@ee.iitb.ac.in, jic23@kernel.org,
	dlechner@baylibre.com
Subject: Re: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <179452418643.1857011.17712598174525760162.robh@kernel.org>
References: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>


On Thu, 12 Nov 2026 09:16:41 +0000, Akhilesh Patil wrote:
> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> ---
> 
> Changes in v4:
> - No source change.
> - Added entire change log for all versions.
> - Link to v3:
> https://lore.kernel.org/linux-iio/20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com/
> 
> Changes in v3:
> - Fixed order of entry in .mailmap
> - Link to v2:
> https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/
> 
> Changes in v2:
> - Updated email ID in relevant device tree source files and driver source files.
> - Link to v1:
> https://lore.kernel.org/linux-iio/20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com/
> 
>  .mailmap                                                      | 1 +
>  .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
>  Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
>  MAINTAINERS                                                   | 2 +-
>  drivers/iio/pressure/adp810.c                                 | 4 ++--
>  5 files changed, 6 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

