Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF974279F1;
	Tue,  5 May 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983926; cv=none; b=BakVX41LTmnO6pei24P5g6FmH+q86CbSiK5lx3JC/V36b1mmxcws2XOBoIck+tbYFQbEOGgzuWoi/hr9D/jE0tHd3Ofy76Gn1u0hxTGsBH/Zo5XdTX/hnbEwvdU6z3Qwjd5e8gBhAC/FhUPOb80jpjn8IT4W4XFOPsxBzcDXpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983926; c=relaxed/simple;
	bh=T+uAAPpi6Zk6FMLjKw7d5dlvfrpLEfZZRq9zV5WPJQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMV0TvLKL9xjTMXuAElJIFyrxM/zJuKRH26y3lD9pb+TMMQmiKL/62FvetcQjsEIpwrcBWQVx/QcsYvkkjJ29AYSifb4u089/uJptoY4OK875HJaBs1yOrlD1omcPOoxVNNnPDWsFR7smNspIGhbgSYZ2T0SywXqKUke4Eshfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltRLh8bj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltRLh8bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF073C2BCC9;
	Tue,  5 May 2026 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983925;
	bh=T+uAAPpi6Zk6FMLjKw7d5dlvfrpLEfZZRq9zV5WPJQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltRLh8bjefsZ5N5GIaW3OcQToDeIKEu7kzBCrpCtJmcQOhM2GFVvTVc3HkTylVnOo
	 H6h5V5bnn5T02Qpz0CGMKZvjP4sX+JZ277j0tbXVPVTVByeAANZxdepIeHdqQcVZws
	 /6Ro7Lt102sfwYCO/2N+1Tcu37Ic+m/W8LJU5/8j323edZB5qS9PduLF9ASAMvtMUe
	 9Dp+UYwyDl9x8nf5BBcAeIpWHjZtQoHxatvxglW5h3GIOFoMnLF0wyl91JROFHmPRl
	 8FgEH+uJwZnQefQkPokdF6ynzZC+m9zn5UlrjgZXNCU+vVfv2DL6iunwrJEzW5tWDS
	 Z00beT9300MKA==
Date: Tue, 5 May 2026 13:25:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] iio: light: si1133: add local variable for
 timeout
Message-ID: <20260505132517.23bdd01e@jic23-huawei>
In-Reply-To: <afhgzKmlXsVnrP8E@ashevche-desk.local>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
	<20260430-si1133-checkup-v4-7-fb3e9dce41bf@gmail.com>
	<afhedNn1hSAXyqK9@ashevche-desk.local>
	<CALoEA-yhUAMg8d5hbYVQ1pAdY1TXL3Fwy_h8O8mbiBaAu_dKsA@mail.gmail.com>
	<afhgzKmlXsVnrP8E@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 12:03:08 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 04, 2026 at 10:59:21AM +0200, Joshua Crofts wrote:
> > On Mon, 4 May 2026 at 10:53, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:  
> > > On Thu, Apr 30, 2026 at 05:04:27PM +0200, Joshua Crofts via B4 Relay wrote:
> > >  
> > > > Add local variable for timeout to improve readability.
> > > >
> > > > No functional change.  
> > >
> > > Hmm... I am not sure about this as previously it was one jump and now two jumps
> > > over the code to get the actual value of the timeout. OTOH, I don't care much
> > > in this case.  
> > 
> > This was actually a suggestion by Jonathan, as the original indentation
> > of the function parameters was horrible, so it was better to just add it as
> > a variable to improve readability. Perhaps I should've added a suggested-by tag.  
> 
> You added it, and I have seen that. Still my opinion stays. Of course, it's up to
> Jonathan to make the final decision.
> 
No need to assign the value at declaration. If that's right next to the use
then I think everyone is happy.


