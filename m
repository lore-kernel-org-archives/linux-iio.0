Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E13E6DDB;
	Thu,  7 May 2026 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149786; cv=none; b=jRc15a72+HpRbg3jR3yUP2tavBCcW1gR1eCMGRTVsevidretqdYeT2tE7pqNx1dzt+/t0+NdAKfc/F5pt9WO/wM3EuHx/AwexI14rAGKJ/GBBcISvTlQu2rJEqbILSADIyPdEoB+qD7FPyNotXwVkXySG11z5hShSThC5i1YPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149786; c=relaxed/simple;
	bh=Oe8xxCQfRopdAyCkRG2gfTW7J8fY9Ro5beU2eCD28+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7fPDrFN/6ztGl5lgZzgvY0Ip6GEstau8PIMXsglDuUqzoZ6gdzJ8Eku8FujCK9cE1cKBUmAMbh//7h//HPWITCx1t8maIL84JgTXVVni1Ica1qWLynPAhIZYTQInEY7PX2ngiq0N/SHrO4aiff8OoHEufEE/2eYmibVeUV2MbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBchYdBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBchYdBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A04C2BCB8;
	Thu,  7 May 2026 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778149786;
	bh=Oe8xxCQfRopdAyCkRG2gfTW7J8fY9Ro5beU2eCD28+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBchYdBhRTQc8BOKQVQ7kLh5TyxMhELzx1HFYw91MJe7W0mnppu18uU4zmQ7639Os
	 PcARgEfjHwCOxzeT9poV7dJqxji/MXiGBGwPabgF9def1TjavpRD/gtgT0l3RJd+fG
	 /rt4Ihk0Lq2vtIkKxaCGfXQWsyVck0u81ngq2QTfHsfGZf6gZ8JVzelAYLnZ8Oi6+8
	 a48854FPDLwaketeevdAQRuqbDGkOSB5MUaRDyeh4I07AWBWAoOLuaZnChvWVz/Pno
	 MBWttK9Zq/JubyNeOZPB4Xmoyzcvxt+mofazh5H52n13Z6SmK0pOtsCHi1vzTpsMQj
	 dQP6XB7fPaXYg==
Date: Thu, 7 May 2026 11:29:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Francesco Lavra
 <flavra@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the iio tree with the iio-fixes
 tree
Message-ID: <20260507112938.369b6a1b@jic23-huawei>
In-Reply-To: <a361f317e3aff614a00ddc8ef908d820@kernel.org>
References: <a361f317e3aff614a00ddc8ef908d820@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 May 2026 12:05:27 +0200
Thierry Reding <thierry.reding@kernel.org> wrote:

> Hi all,
> 
> Today's linux-next merge of the iio tree got a conflict in:
> 
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> 
> between commit:
> 
>   cba48e44357b ("iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer")
> 
> from the iio-fixes tree and commit:
> 
>   7216b9f7e9fe ("iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO")
> 
> from the iio tree.
> 
> I fixed it up by using the version from the iio tree. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted
> for merging.  You may also want to consider cooperating with the
> maintainer of the conflicting tree to minimise any particularly complex
> conflicts.

Thanks. That's the correct conflict resolution.
