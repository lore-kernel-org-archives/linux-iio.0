Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126B37F8A2;
	Tue,  5 May 2026 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978022; cv=none; b=UaeO4mb3tGuf16aHbCHTYUN/ELdVgXDjayaBe41X4qDTCIjApmXLV8jwG5p4j7Pv99yMrBcJ3sD4uGD0/jLo07P0YGnmuDgN2G23Y1Q712kMHJFa61Ku+pt9kesRO2nzwS3AjAhQ/J3haWjesoElOtp15QW2m8yU7LMv9B9za9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978022; c=relaxed/simple;
	bh=32TlcTEMx1Mbzn0Gs/lnWQJYQ/HQQGkV76hj7abltnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT/wVAvfKRtZ8G9U6GCv8mQs8F7jiB+mBMYINIXIv0hl85zAnkSHViGCUDa0pBVXUAlt3rDXI1O1SjJIWq9FmO2MNEbyFAxLT2UV0wL/gG412zIvOqpfYxBEfgF/cOL7bE5cc0lCC/zo4TIAdNroYBshfjnyt7k8NzFS4mkLgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq4H0nb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq4H0nb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A848CC2BCB4;
	Tue,  5 May 2026 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777978021;
	bh=32TlcTEMx1Mbzn0Gs/lnWQJYQ/HQQGkV76hj7abltnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lq4H0nb5HiXE61wqdYfomuRUiD/XFJrizuaazj16cX+AMeQtPAns4fqnENEEoHLag
	 PwV+IjgIA/8cMIUw7xWpxi+stmkPnj1CblvqwwOwgWxQ1PoVu3//SZgvQBv4hAgmrj
	 3w8+IvDH1PgO3OZ8RvdawYWTdSh4QtsZCqoXN1NDC9X3z8QXwokzsoEHxqFw72m3Ax
	 dhE0Tani24Z7b3BYSA4NQkFYshXM/C3Be/wAqq4GTvLbnccMais6kc9kvqLUCj/WYG
	 mSaDhlqetBgjda78DEd9GoogfqaWcMIaIdqWbemgPmoud3zd48fH54TdZWvoHLn7iM
	 +IgcsDzwDPkWg==
Date: Tue, 5 May 2026 11:46:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 09/10] iio: imu: inv_icm42607: Add Gyroscope to
 icm42607
Message-ID: <20260505114651.57adbadf@jic23-huawei>
In-Reply-To: <20260501221152.194251-10-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-10-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  1 May 2026 17:11:48 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add gyroscope functions to the icm42607 driver.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
=46rom a quick look, feedback will be near identical to the accelerometer
driver, so just check this for similar things to change.

Thanks,

Jonathan
