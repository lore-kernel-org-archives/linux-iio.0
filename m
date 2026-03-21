Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC20126F0A;
	Sat, 21 Mar 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774099023; cv=none; b=LsdIxf/on6Cdcci85pmDQmLzuPZ4XOJc/VniTTDjms7UcrwQjY/VAFwxL4fM1yQdrvx/5iVRep6p8AHDXcSjpVeqyEsPv3/4u/7pJ1E6KgLY71eEKi4BWvOUoDFcgqmFXoc3/Rg0wlhhZnOdI/pQ+gPjgqX/l2qcl9yPYKUsxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774099023; c=relaxed/simple;
	bh=WF5auv/jBaIBbAoJsBJO1yMRyYxEKbm687NQkpETNuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOXxSqUsxM+N+22Hd+1lx4nAdZqSUeFFqH5Xi0r95YRI5ia/St4XQvoH11Z8xaDQwD6/CYQGJ436Rb+8bHOLaUJbAq64ZxMoJza0dRbJg2Jx5SX5rUTTxJTT7sAvDpmkYDaLglSXG0pK2SuY4ZZGrEkXZ4V4RFjV2MNRBrRr6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGO7t/ic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGO7t/ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D3C19421;
	Sat, 21 Mar 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774099022;
	bh=WF5auv/jBaIBbAoJsBJO1yMRyYxEKbm687NQkpETNuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGO7t/icTbVmLoaPDN0SSFByhDIT6xe+7Rgq+e+iOeivvmA8EibiLTgXmkznKhFlO
	 42IcC0/vkEVSnQ7CPqw3gCiL84YHpqF1cxvgs9PUr6M9jQpsGQf6Ykf6Kg88o6TxA3
	 NbeQXayFY0rf9Ybo/uEWRE4TPecrpn4gc3+bXYba6UIJpVbonDQd2LeApQRQuj528O
	 h0OwCs/Slfe2yyMWZSoiuZBYl3z5s8EklHVdofNTSWztWiChkRQ2xC/aiwIViSWv88
	 KQzkxxoXH44Xmn3T+iCzQ0B3zZm2HZrQR52nfb3M8t+sXaVDIuiyPCDR70CKd8QuG3
	 jtJ6QmLfkrI0A==
Date: Sat, 21 Mar 2026 13:16:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: iio: ad9834: use sysfs_emit() and
 simplify show functions
Message-ID: <20260321131652.2f25dec0@jic23-huawei>
In-Reply-To: <20260320222424.53294-4-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
	<20260320222424.53294-1-grondon@gmail.com>
	<20260320222424.53294-4-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 22:24:24 +0000
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace sprintf() with sysfs_emit() in sysfs attribute show functions.
> sysfs_emit() is the preferred API for sysfs callbacks as it is aware
> of the PAGE_SIZE buffer limit.
> 
> Also simplify the wavetype_available show functions by removing
> the intermediate string variable and returning directly from each
> branch.
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Similar to patch 2, I suspect this code will go through a lot of changes
if anyone does the work to move this driver out of staging.

So I'm applying this mostly to avoid anyone else sending patches
to do the same!

Applied.

Thanks,

Jonathan
