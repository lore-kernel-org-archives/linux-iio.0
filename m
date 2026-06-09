Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6041B360;
	Tue,  9 Jun 2026 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010442; cv=none; b=gr+YjvXteSSGesZOy09/WTUMG7+WVSl32JqgaNiQPtvUYEVf9/3jhnp2ywpTYhXJCB8E6WIuVKMPNFCaAgOPtfvpvqkjLGIBpXI+piDntV1TK0xm/s23qnj3WQPt6N87basFxFR1dydZNSqgOApchP30SEVTOU0LQERfL4mczH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010442; c=relaxed/simple;
	bh=cDgOxFFLJEgGiCL329g1zL9Bq2C/gn38Umbcu+B33Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrTR+52e5cR9k7evkBHvsDsTEdKP9RBPFM4g58boBv3PM3mQ4Fu14UWo1n9zFDPgko5FMgFe2940aN3T7kcKOpJ/IlSTeA2+zqLgax/mkHOq5/ok1q315EbtB0lp5QNKKNdOu8X46plzkToXTSAtqw3cJoiozV21Mwy9s04QzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwOgMt2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwOgMt2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500091F00893;
	Tue,  9 Jun 2026 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781010440;
	bh=iYuC8bCosGWBPcUAim+z3dx+7sA7/tBikszH1HXdeQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kwOgMt2K5n8UG2B1gdWN3q+hTzA880irF7Vqgzk7m5JDO1x0qmoGdDnUNxfLuf6Yb
	 Opd4kvcrF/2WqsD014m1VrlMXakFDI8VF8VC6mLlqKh75azKrbr0jPGsYcL/b8Td6y
	 CxP8A+TDmU/QLLeYoYCdtbP6l4tgfUqV/fW26mpqC0vgqjAKm56/BpJrDVsMRTGrrm
	 TWTunl8y6CI4ZRPooOvVfePXA+alFclaIY5A6/RnQPheDOYD8wK2hERxfpUry9MXNA
	 FLZ2r86N6fqXN1KJt1ssVBT7c1O8Fx4ylkrv74m2mDBWc8MIr3DAOmMIPeXZ9OiYy9
	 8spgKatUsNQxQ==
Date: Tue, 9 Jun 2026 14:07:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, "open list:PNI RM3100 IIO
 DRIVER" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, tduszyns@gmail.com
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
Message-ID: <20260609140712.2e5d1640@jic23-huawei>
In-Reply-To: <20260608085754.32def4cd@linuxescape>
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
	<agAvydze87mMLaVC@ashevche-desk.local>
	<20260608085754.32def4cd@linuxescape>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 08:57:54 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi all,
> 
> On Sun, 10 May 2026 10:12:09 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Sat, May 09, 2026 at 07:14:35PM -0500, Maxwell Doose wrote:
> > 
> > If email is not bouncing, let give him time to response. If there is no
> > response in a reasonable time (usually up to month in the summer time
> > due to people usually have long vacations), then we can act accordingly.
> >   
> 
> It's been about a month now with no response. I believe it may be time
> to make a decision about who becomes the new maintainers of his
> drivers.
> 

Send a patch.  Won't go upstream until next cycle anyway so plenty of
time for any late feedback

Thanks,

Jonathan
