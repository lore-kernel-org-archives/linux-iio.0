Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF03112BC;
	Sat, 21 Mar 2026 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124061; cv=none; b=K3CXRmHBfrEF5GcK5nf3W8VLMNparRL2aMWHiYyPnB5hc131TnjjWnDo08MQcDFNOY1ktbFuOPLaut9CCob5qQdU2Uynjrxp/arQ9RuOl3CrW3LHECeyl+ca+YMY7nijirs2YX5myQcbebLusajrwd2LFlm17LBx9h5QqemHkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124061; c=relaxed/simple;
	bh=oY8QD6jpm6/VMMcN2hDbAVaatWcxfnqJhoKkdV9sV4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0tExVfhJnKmdZf1jP9PaGNKyQQrrWpmj/F8oRX4yvOScors/TbVu55lAcNHjPbJXwimU0/dD6IYmYlrSP5k16LAOnRX2rhTmlnAI3zvT5AYoaBiCQ/nNe22gCLczTPATpILQPWGJ8BCkD0ze+0TgS/qQWKwrCjhK1u3XNg8oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbqqKGi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbqqKGi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC1C19421;
	Sat, 21 Mar 2026 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124061;
	bh=oY8QD6jpm6/VMMcN2hDbAVaatWcxfnqJhoKkdV9sV4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbqqKGi3ywjXLbCIy8FYbvKmTACDLIFU06LmDsiPlc+VxGUUxpP/c0PeMH0BoZjux
	 7xfxJhM3n9yD2596gQwxj3JRC4nNsxbFTULMk9Y4iMtuh1JWUsvmxhZhJAYUkIiKsF
	 eOCPW6vRIlPQoi3W+TpTRmqAg9WfDl5bHDxeE4scdPSsBnUCwGVmmHCWTgJtCwgw+X
	 xWZ6w++/Kunl7eZ1em7D7IZztl1qWByC5dF82gDLjIohu504Po9appIf5fTSuVR42c
	 e1vXaYjbS8KB19rJv+WSrTRs6rzWvTiss57PF1eO/N4MzGvIt1c0iF1VbAdT5UvDJp
	 rK2dV5Phnn5mg==
Date: Sat, 21 Mar 2026 20:14:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, shuaijie wang
 <wangshuaijie@awinic.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: fix firmware read on
 big-endian
Message-ID: <20260321201412.16d86fe1@jic23-huawei>
In-Reply-To: <60aea3c6-52db-42a5-b1b5-b0af50e3342b@baylibre.com>
References: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
	<abfZyvsfzjPv08QM@ashevche-desk.local>
	<60aea3c6-52db-42a5-b1b5-b0af50e3342b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 09:36:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/16/26 5:22 AM, Andy Shevchenko wrote:
> > On Sat, Mar 14, 2026 at 06:20:12PM -0500, David Lechner wrote:  
> >> Use get_unaligned_le32() instead of casting to int * to make sure that
> >> reading a 32-bit int value from the firmware binary works correctly on
> >> big-endian architectures.  
> > 
> > ...
> >   
> >>  	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
> >>  	bin->valid_data_len =
> >> -		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
> >> +		get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
> >>  		AW96103_BIN_DATA_REG_NUM_SIZE;
> >>  	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
> >>  	       AW96103_BIN_CHIP_TYPE_SIZE);  
> > 
> > I gave you a tag, but I have a question here:
> > Hmm... memcpy() happens to work probably due to keeping LE as LE and chip_type
> > being a byte stream itself, if AW96103_BIN_CHIP_TYPE_SIZE is bigger than a
> > byte. Otherwise it may suffer from the same issue, no?
> >   
> 
> I checked how bin->chip_type is used and it is a string, so not affected. 

I'll give this one a bit longer so Shuaijie can hopefully take a look.

