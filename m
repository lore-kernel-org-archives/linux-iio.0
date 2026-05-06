Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804353ED5C3;
	Wed,  6 May 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088563; cv=none; b=no45ubSCZ2wuxUVCRre87RVxRg0XBZ7Ecn+wgorg7/cxEp+7FTMXQNUiqweRhIQrbFYg6WgT/x4mSxHgV714me8EECJuNONkBduJl5cO9IOMLpPrrK4NcY/VVjOR2JU9vvqpuOiV36k+aik/3+ocRvTb5HeQzF60wDg/PBBUH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088563; c=relaxed/simple;
	bh=LxNzlY10vl7a+Z9daFTqu/SY1x0YAK7FLYT5CVni4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duazaW6tf8yqLcFWhFHx+G4nSUaksoN3eGWuXPmlYjw0wmtS41JRgvUCX/oI7YhzyFOzYD9cVMHGuzfQ5E1C7S7egnmf/6gtvFk03MCzrNKX/aPeMAG4/Bpo0pQ0NzFjsIGYTarHHeRUoUO896hqChDcniVWCpiILg/I2HvzNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRJsZJTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRJsZJTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA6C2BCB0;
	Wed,  6 May 2026 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778088563;
	bh=LxNzlY10vl7a+Z9daFTqu/SY1x0YAK7FLYT5CVni4jw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PRJsZJTpQAP5jG7TTzP3APtANMpxkCq2gLAScVygMIOZHDuarU6y6I7SWXjLJZwa8
	 6LoiTwKwM/3jcD6oooJw6PQ5mkSWa23hIIYHBNazsuI7oQj2lXqzJWxj1xRPftKrlk
	 5UqoHAyrWAPjc4+xijIwVGEz3VVseE30yhGVQfpcXuWR7bMygGJ1NKfizCwPDIRLIn
	 3ORlx3HBXbAWU6vwQl3RPIch/g6SGhrlNo3JFbtNI9q5LDZP203POxPhJ6+BYnBLev
	 DKzZmxRdc4n2TjiyNh5BSnMWKJLGgokRSJ7BbVFBM+nMujpeSr2zDgM7BxTkQ9fU90
	 Djh4WEzYd6zlQ==
Date: Wed, 6 May 2026 18:29:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 00/12] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <20260506182912.12eafac4@jic23-huawei>
In-Reply-To: <egslrxgxzuj2rqsrjwo6xyjygnuwqqaqz7twkyetxtrhve2gfd@unmzoontm6kr>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
	<afnpvJ5dwkZBcTHL@ashevche-desk.local>
	<egslrxgxzuj2rqsrjwo6xyjygnuwqqaqz7twkyetxtrhve2gfd@unmzoontm6kr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 15:29:55 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/05 03:59PM, Andy Shevchenko wrote:
> > On Tue, May 05, 2026 at 01:35:01PM +0100, Rodrigo Alencar via B4 Relay wrote:  
> > > This is the first series of three on updating the AD5686 driver.
> > > 
> > > A bigger patch series was sent before ("Extend device support for AD5686 driver"):
> > > 
> > > https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> > > 
> > > This one adds a number of cleanups and fixes, like:
> > > - Refactor include headers (IWYU);
> > > - Remove redundant register definition;
> > > - Drop enum chip id in favor of per-device chip_info structs;
> > > - Fix internal voltage reference control for single-channel devices;
> > > - Acquire lock when doing power down control;
> > > - Fix powerdown control for dual-channel devices;  
> >   
> > > ---
> > > Changes in v6:
> > > - Protect powerdown masks on read access too.
> > > - Minor changes to power down handling and constants.  
> > 
> > You were too fast, Jonathan applied some patches already.  
> 
> I understood He had applied the some of the fixes and was to wait on the fix
> for the lockless read access issue to proceed. Also, most of the series have
> been reviewed already. Indeed, I suppose I've been hurrying up things... will
> slow down!
>  

If you do a new version (I didn't have any other comments to add
on the remaining patches) then please just drop the fixes I've applied
off the start and note that the series is dependent on the tag in the
fixes-togreg branch.  No idea if sashiko will cope with that but humans will ;)

