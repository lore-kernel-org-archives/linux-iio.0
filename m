Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794475503;
	b=I66zgJM8W6d+p+mVKTP4Bk7DmDRRXSeXaCC6Tk3pf4UQ19LR3INIrcqptk2i09vQLFMd
	 ndD83wL+R/IL913ZjhVxN0geJlC5hipzmgOGH8vAmt04PL5vgGEJtANdFHyVJ+FYZNipD
	 zm2173hZPO8gvROOpctqxosrbujPBkmHhR8w9VxRgiXQLR4SgJEYwRZ7nyHWvZftQAgBk
	 IGnPu3uyRftqpjk+jsSwTIZ3p2rw7a0uTNjbl1MeeWm2lu4abugHlVR4cE4jNZstw+H4Z
	 Qy03+a0LhZHTL3Ps0PM2OewAPPMikK3uTcdyYpZPCRRPTr9ztuGv6Zv8g4MFjgpmJrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475503;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IWXvVUCKSmZLHb2fEiIv4nMaSQa+eIkiYQCoUrncRak=;
	b=HUKgVIxfAkck0tHXsQbiEsRFJMe5Z3x2kqK2wJBCEXVPRgiqqtTPCnLpCYD4KaNXCXhw
	 IWTsdpff7Q3NyVKlecBQxHlWVKnGP09WNXvbRkKrF6htqpolcS7wgHcj2rktR4N2OjyTp
	 hFtpcJzZt8W9qa15xXryECR47ISscxyiX4hAQcn/PtAY3OtTFVZb55u6SQRBwjEhTkO7y
	 E0MM3H12ehN8qODuXsZJ+y8MTsVJilbNbIRHHzg7VHRY07pbIzoVQc6dNoH6WJ+CeOgRP
	 iNatREICvMORSbeAALUJi2LrZT0gcIaag6hLkH1ci7Ea3sEobQbjB08rVOkNuqfOC5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESzsZ0U3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5444606A330;
	Thu, 12 Nov 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESzsZ0U3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794475503;
	b=okXx4v2fAhoRm6rIFPkKPFWCJyMDnQ3lmu4Jv58J65y++BpGTGXX0314mpKBhVjh+z3K
	 qsMwNEEMKmHZH+tIu8LUUrjgyc9KXL/YqW6F43FN1ekToHjimUoa9/DcS8D9RquT3Er3F
	 jwAUDf+XoI9eqiDkcWWolNgoUqeMNGgDtRqXsLnd5TjfBpjyM83U4tN4BzfKHHA8ay+Z4
	 CH1z1AvDH6DHORUbHQBcaeInQ8hmprZbHLdLa+a4AZP1mc5WBsup0gnkBDl44fE80wx/X
	 f2uh8ZVu0SYs1BKDGvIV06Vlqad9VWYWmqxvIQpr+TwKLqchBXd4ojd1sBjPzYjZs4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794475503;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IWXvVUCKSmZLHb2fEiIv4nMaSQa+eIkiYQCoUrncRak=;
	b=WdQdd6i2c7Q+JwC/h/4rPT0R+5odWxDn3fK1XigVDzWaiseL2q2ar2ZG18pXyp+WiOp+
	 U11JUR3zpVFMep4kzQq3sscmqlDFLDlxhIrGSVHn9IJjc42DcMzKrInYLTe/zIJ0vgtNn
	 kEE3/cYwUv7vhTOsZLl6648LFof9O8qOXlQa08XcKVrlefZvYObGjP7Tq8dNrYUw6Jnt5
	 kL4bCAj9USdb+B7YyuJyZ9s/qeO9vRWyWoUC1UQ27K+AE7cCqIzpmEtTO7Y/KuaEOP2rs
	 WvEtqLuuFOacqUmgCCcLrqThSAV+iDkT29A8U1eKQnx4Peu9OIdt9mpOm28OnDyh7gw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 0D4811F00A07;
	Thu, 12 Nov 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475503;
	bh=IWXvVUCKSmZLHb2fEiIv4nMaSQa+eIkiYQCoUrncRak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ESzsZ0U3cv5yQAPJ5JKMLDJKbgpCaU79A6eWV33eUTvanPg7/vKJRs56LIz9ugHpd
	 Omg6qb5HUuQMrP767+jV6SZVghez0czWsH0WOPQiZYmXvQBsSgn4UWSzLaSemEmVPv
	 T22FYACCTtN2udiDQ530n57e3skP+gUsCIT3j+ezV2m96gguOzVe0zr/ZPE6zoqP4V
	 G33r2EWtiydWLClb/xtCfQb2eVimCd7GPM667a8PTfyJRnViODaRTTRWydsHb8xoSM
	 ReVYqK3sOTVDiQ+N0Y80Z8z7EGy8cM5WZ8lqWOgA7T6gzYIrBZbpQ+V1dAh7bRQgd3
	 joyyAShzift7Q==
Date: Thu, 12 Nov 2026 10:24:56 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org,
 dlechner@baylibre.com, robh@kernel.org, conor+dt@kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, akhileshpatilvnit@gmail.com,
 akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261112102456.00001158@kernel.org>
In-Reply-To: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
References: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 09:16:41 +0000
Akhilesh Patil <akhilesh.patil@linux.dev> wrote:

> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
