Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56230DEC0;
	Sat, 31 Jan 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878252; cv=none; b=pxaTn+VOo/bzBRVlOc93NWcVkn41R3I92Kv7xLFADLNRJyCagMeainNqPXt8FD6VPPdlaE+9eky1RwEKx94C2AeEtyKYilBCQ6hc44RZJMilkh4Zfy11ndL3b+jNSL+9ni48VU8R32HGfNlwZCo5RAcF8BVNIWFWZISmwgqgYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878252; c=relaxed/simple;
	bh=O3q+x+gwQ2TcuZN5vB4aSDUBiDxUNT/auhtstOa4Mlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKCiz3jOgxLU4PDnQd/UlX0S3gUcVLLGYiH4gOJBhC/qr7Ryb86xil3AOnygUU6i2pq9qRpRG6ZyaZDZzjySJ2mTYF8AfW8ZZff7pvtFrSH6TCAKCOIgO0UfhG4iey/cixdoMQw7uvgMJdwPeJR4CyZwTEbQD6yOJZKCnOdulOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1LCKBMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1LCKBMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE1C16AAE;
	Sat, 31 Jan 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769878251;
	bh=O3q+x+gwQ2TcuZN5vB4aSDUBiDxUNT/auhtstOa4Mlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1LCKBMUTtPUsbM4tE9hyIzDNBJMcc9JWDIYITx57VdgWXxyzF+8CDZPxIXXKgDUz
	 h8BvAVW2x6y3SId2Ljsa+v2B+HOqxo8CYKpS7icYaDZNXL958njK7yUiIlI8J/kjQV
	 AO3/5KcMaHcumycrh2iRDhMDCSdR++2+dZ9M7KUQQoX+56D/yMgWpHuSB6h9VkPvTk
	 ALcjTRuT+Qbfr6mVX1UQytrY8FOr8So2xN1G7hRoqujE8bGfIbxyDlr+f8UhXrQwsZ
	 HP9YKNiMnNc/IAaqUNdZVBOYYwT6L2D4Z9P1jLxSwpYxSgUONsqduDrTHCPV4nnWUp
	 FjhQDiTh9mSnQ==
Date: Sat, 31 Jan 2026 16:50:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Fabio Estevam <festevam@denx.de>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Chen-Yu Tsai <wens@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Message-ID: <20260131165040.381d414b@jic23-huawei>
In-Reply-To: <CY4PR03MB33992FFE27A9A7DB4D7BF9069B9FA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
	<aXw_5nryp4dKHVfm@smile.fi.intel.com>
	<CY4PR03MB33992FFE27A9A7DB4D7BF9069B9FA@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 07:32:58 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, January 30, 2026 7:22 AM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> > David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> > Andy Shevchenko <andy@kernel.org>; Matti Vaittinen
> > <mazziesaccount@gmail.com>; Fabio Estevam <festevam@denx.de>; Sakari
> > Ailus <sakari.ailus@linux.intel.com>; Chen-Yu Tsai <wens@kernel.org>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
> > 
> > [External]
> > 
> > On Thu, Jan 29, 2026 at 07:21:58PM +0200, Antoniu Miclaus wrote:  
> > > Remove unused dec_rate field from ad4080_state struct.
> > > The driver reads/writes decimation rate directly from
> > > hardware registers via ad4080_get_dec_rate() and
> > > ad4080_set_dec_rate() functions.  
> > 
> > It seems you missed my reply to one of your previous series.
> > Do *not* thread emails which are independent!  
> 
> Hi,
> 
> I didn't miss your previous email. I checked now the command used for sending the patches and it didn't include the --thread option
> 
> From terminal history:
> `git send-email --to-cmd='./scripts/get_maintainer.pl --norolestats iio-unused/000*' iio-unused/000*`

Experiment a bit. These are threaded with all the later ones in reply to the first patch. 
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
is set in the header.

As I mentioned in other branch of thread. I'd actually prefer sets of patches doing
a similar thing bundled up in a thread with a cover letter and clear patch numbering.
That cover letter can provide some brief background info on the common elements of
the series. Even if it is trivial it puts a sensible grouping on them and reduces
how commands are needed to apply them.

Jonathan


> 
> Thanks, 
> 
> > Really, you should have something internally at the AD to explain the process
> > and the simple things like this.
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko
> >   
> 
> 

