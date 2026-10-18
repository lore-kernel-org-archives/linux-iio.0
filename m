Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BE37F30C;
	Sun, 18 Oct 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792346949; cv=none; b=QHm01hUfH25ANym08+5DAMAi9P6Gbrpkxr6aHG5wQde6PkiNkbmytjKwmQwHpYbhi/sVbHfEs99XCcxNUEWBZx7VYfvZOEgkQLP4hnNqRhaO4xQGBk/YLa1SkpbBd4cH48yOaSIwtROwriKjSWcrw2T0RihJlN0581/uNUfc4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792346949; c=relaxed/simple;
	bh=uD8zSl2dQZq8Z8q7kIaeUyTShq+Uabl63Aey0xXeN2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWVkcEGqCP/k5dSJs0VwGxJ5Q7zxGYeSpnC7D5EO2BYR38V3GvvHnXsOLV5jfK/nOngXG2RMT9nrUSzB4IMmDlP3KYz/d9y/gpi+LxNhvzg7MtlVmrwqAZmtIpPxxx72ArC8OBHpUl1pN2FsbZ+28Z3ECZseBDV8DREAIgfVPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLYAFWrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLYAFWrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9E41F000C4;
	Sun, 18 Oct 2026 18:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792346947;
	bh=68ZkEmqdatj7eVPb8H4FZj/isxP6RhwLmZ6de5KQwTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YLYAFWrtmz+j4HK66Hp1DtQ13lcjMHDS48ZwCERj5z+xQ6fkHWn/W85FyLMzM5ebi
	 I/c/qvu5yfWB1P/Tk5lC9ePZ+XamRnl+wxi4tvlaQA76KakypvvoYuDvIaK1b9iNCB
	 PYlosHAiMbtFe8+0vv3fQKuT5pqwhhQb3gkcSBDCLH8iHR5Ee/LdoJesmXZ2/RkXUX
	 MyvXR/+vybXK5WN1NRBgNIuevKmIUzdWLkWoecpAeSxXKOsXnCHvbu1O8tfK4tXpKT
	 uKstpwngv5PvltVnlFgaSi7erUZBgz+OipWBmy2WMd/iB2CGYtsNg79EsInua567tv
	 O7Pg0xUUDu48w==
Date: Sun, 18 Oct 2026 19:09:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Arnav Kapoor
 <kapoorarnav43@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>, Benson
 Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, chrome-platform@lists.linux.dev,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: cros_ec_sensors: use sensor_scale union
 member for CALIBSCALE
Message-ID: <20261018190902.6f0466c3@jic23-hlaptop>
In-Reply-To: <atRvqJiiAjjfbDcE@google.com>
References: <20261011045410.356156-1-kapoorarnav43@gmail.com>
	<20261011191641.4e9e2ac4@systembl0wer>
	<20261012211733.575305-1-kapoorarnav43@gmail.com>
	<as6Mr7BSbJeJRlBq@ashevche-desk.local>
	<20261018000206.55b279de@jic23-hlaptop>
	<atRvqJiiAjjfbDcE@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 07:05:12 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Sun, Oct 18, 2026 at 12:02:06AM +0100, Jonathan Cameron wrote:
> > On Tue, 13 Oct 2026 22:55:27 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> > > On Tue, Oct 13, 2026 at 02:47:30AM +0530, Arnav Kapoor wrote:  
> > > > On Sun, 11 Oct 2026 19:16:41 +0200, Joshua Crofts wrote:    
> > > > > Please add a Fixes tag. Otherwise looks good to me!
> > > > >
> > > > > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>    
> > > > 
> > > > Thanks for the review. The mismatch was introduced when CALIBSCALE
> > > > support was added:
> > > > 
> > > > Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS")
> > > > 
> > > > Jonathan, could you pick this up when applying, or would you prefer a v2?    
> > > 
> > > No need to resend, `b4` will scan the whole email thread for the tags.  
> > If it could put them in the right order for 'late' fixes tags it would
> > be perfect (easy fix though so don't resend!)  
> > >   
> > 
> > This driver tends to be well maintained so whilst I'm fine
> > with the change I'll wait a bit for a tag from one of the maintainers.  
> 
> Sorry for the delay, I somehow missed this in my inbox.
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Thanks!

Applied to the fixes-togreg branch of iio.git.
I considered taking this one the slow path given it 'works' today
but given we are very early in the cycle seems nicer to just get
it cleaned up.

I dropped the Assisted-by LLM bit given guidance on that has
changed again since this was sent.

Jonathan


