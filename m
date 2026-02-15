Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE51FD4;
	Sun, 15 Feb 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771171394; cv=none; b=LSp6o70GLCWQEr6R975eJ7L4zS27OG4GMnGeesEIoS0qu0FY4C4+Z/eOEtxVlv9lDfuU/kWk4hH/TzJEBRpYknUfdzyBTwlGck/5/EcWMFc6kmaqOE2W01VDonKzKRFSeh4n1w6sEOpJ7Mup6KbhRkG0kIw6LFnONvvpUF2lx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771171394; c=relaxed/simple;
	bh=TwuHCg/8GsYempdFzsIoB7iclf4gD0Ok8l3F8A9Gwiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9XbyzFvmkqRbxBSXuCLSjo9xYJpM34C6L2jXweEKuJ5eiY616+yi0gI41siIE28tUz1y6ylfjf5lHZAoyblsj8fm4E1EUM9teB6sh42f+KYOfWmJ34/JrNND+QBlvXqKbOTr/IsSUI6fEbVNu0fNNbblVjse8OkyB0btGD1ysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcD1Nq0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcD1Nq0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8587BC4CEF7;
	Sun, 15 Feb 2026 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771171394;
	bh=TwuHCg/8GsYempdFzsIoB7iclf4gD0Ok8l3F8A9Gwiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZcD1Nq0Itv+AZ0ScR6fX9OmQ4q30ohfLwJZoHw7p046tPoCqk8PRDolIphEHLFwCg
	 2zNKxGJetfTwB/6/n7ysL4vgAXCQ85qkzfBWXfegp9B8Q9URZiw623KjiAe56cnJY3
	 Nz7ZUS9NAMfM9MCQODr5VT/LLwwtoX17TpAo0dIOwfdqiMqLbCknHVFyfo3YEMVR4q
	 RiQEqCIyWFG6ilGR08MmDAYexIPgbg/BgQsSmvRLOdowQSmpJOFxh2yBTb8nZwsUA0
	 /lJVXNRnOnirMv8iaNtCL29OzN7QtUWWig/YkoWK22slQbjJYEQxH7odlf6jR4HzG5
	 Eg3j/46G0TxNQ==
Date: Sun, 15 Feb 2026 16:03:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Message-ID: <20260215160304.083cd436@jic23-huawei>
In-Reply-To: <aZF2PLePepfGma_N@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
	<aYuNr8alZt-mjd5x@smile.fi.intel.com>
	<appnjr2asjxadbvcf2fosrkvfwj3dkcnvq7tk74i4xa4ku5zr3@c7qedqneukyn>
	<aYyFpFAQcfn7Qifn@smile.fi.intel.com>
	<20260214183051.712c8c4b@jic23-huawei>
	<aZF2PLePepfGma_N@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 09:31:08 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Feb 14, 2026 at 06:30:51PM +0000, Jonathan Cameron wrote:
> > On Wed, 11 Feb 2026 15:35:32 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Wed, Feb 11, 2026 at 12:55:30PM +0000, Rodrigo Alencar wrote:  
> > > > On 26/02/10 09:57PM, Andy Shevchenko wrote:    
> > > > > On Tue, Feb 10, 2026 at 07:42:03PM +0000, Rodrigo Alencar via B4 Relay wrote:  
> 
> ...
> 
> > > > > Yeah, but it also means to add (a lot of) missed headers...
> > > > > 
> > > > > array_size,h
> > > > > dev_printk.h
> > > > > mod_devicetable.h
> > > > > mutex.h
> > > > > stddef.h    
> 
> ...
> 
> > > > This is the output of the iwyu tool without this patch series:    
> > > 
> > > Have you applied the configuration Jonathan made for this tool in relation
> > > to the Linux kernel project? By default the tool has a lot of noise, indeed.  
> > 
> > Worth noting that I'm still evolving my config and suspect there will still
> > be a bit of 'taste' applied to the output even once I conclude what the
> > best combinations are.  So to give my view on the following..
> >   
> > > 	#include <stddef.h>                     // for NULL  
> > Not this one.  
> 
> Why not? Here is the NULL in use, but...
> 
> > > 	#include "linux/compiler_attributes.h"  // for __aligned  
> > Never that one, but I sometimes feel compiler.h is fine.  
> 
> ...taking into account this one, I would rather include linux/types.h
> instead of any of them.
> 
That's where I'd go as well.  I think this might be the first case
I've seen where there is no other reason to have linux/types.h (due to the
sub 8 bits bit depth and use of unsigned chars rather than u8) so
I kind of assumed it was there :(

