Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972FA224F3;
	Sun, 21 Jun 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050153; cv=none; b=DLNtDCpHdvvkX/ec3iTcp0yohY7WfiQBC1oEleGhYLwM9nw4JU7TIcVCT1GAcnoX66LFrEjaxhm5ATru9o/OGOe06levq7SAbiIqFwP8IB9BIJlrWtSFJDdKdFzkpOFPoqB/HSCcwFS+/dbJ2sriM8bTUVLLuLhcJyuYjF+bHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050153; c=relaxed/simple;
	bh=vxE3Ap9a85GbaraPUt/eVstYCFKevQ/aa9ank8m1ydE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMqHg74OvHf5eKU4Ev7a1TvkDzJypOpR6Fx3e0I/6kmSZ409U9t55IpH0RINyprsqZkO27WwPaiasNTFadvbjPjZ8zRfst0uhyMHSQcI0vECZW1TGbnkYPEpsCVLf4UiNHin765uxmMLrZx6zeoWn842hkgkHo5eE30moXMmkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3/0qzZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3/0qzZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A851F000E9;
	Sun, 21 Jun 2026 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782050152;
	bh=JEeR55xkeQ2469br2GYIfdcHuq4rzfe2O0SlMMFvEb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F3/0qzZGeYsOP2RsHyhJrPLWkG8dSlXnLSaeAgDHekM6Hagk1TQMKkg3dfN7mB20O
	 q/tu+VCiV7ILIRvo9Ko0EpsIusAjgadXwPHij/biweWbRXlHxRQYbQYau4RkOnRpru
	 ZNlFyMTqeQ/WZ524DK7/3X7ndpf0wtJDiHeGHfaYJYiimvJHjtHeylQ5qDvCRCatqA
	 vQTO/vEDsSWytjbCNuXLPp73j7FIcUeeBfcKBnu5YOEtlfJTm2j+6cbbd1XxK6kN6S
	 cp0Vy+fM7hT54x777NhcP1NZckvfAvWoeFUk1gPW9MhBPMRVaXPdVjJFMtDGkfinHl
	 TFVkm/N91qnYg==
Date: Sun, 21 Jun 2026 14:55:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: ABI: testing: iio: minor cleanup
Message-ID: <20260621145544.23edacf3@jic23-huawei>
In-Reply-To: <ajJELTX_uJg0steQ@ashevche-desk.local>
References: <20260612121342.181358-2-manuelebner@mailbox.org>
	<ajJELTX_uJg0steQ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 09:52:29 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jun 12, 2026 at 02:13:43PM +0200, Manuel Ebner wrote:
> > Add parenthesis and dashes.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  		used to mask the buffer output value appropriately. The storagebits
> >  		value also specifies the data alignment. So s48/64>>2 will be a
> > -		signed 48 bit integer stored in a 64 bit location aligned to a 64
> > -		bit boundary. To obtain the clean value, shift right 2 and apply a
> > -		mask to zero the top 16 bits of the result.
> > +		signed 48-bit integer stored in a 64-bit location aligned to a
> > +		64-bit boundary. To obtain the clean value, shift right 2 and apply
> > +		a mask to zero the top 16 bits of the result.  
> 
> We can reduce a churn by leaving 'a' as it was before (despite being long
> line). But I leave this exercise to Jonathan if he wants to.

True enough but I'm feeling lazy today (too hot and getting hotter :()

Applied.

Thanks,

Jonathan

> 

