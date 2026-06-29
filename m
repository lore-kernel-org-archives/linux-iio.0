Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3A2FD69E;
	Mon, 29 Jun 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757740; cv=none; b=LI9pndaKAYYCAiK0VCJ4kR3RA/WHIxQiCyD+9EK7YAIdpDJPLNk3YIHG6bDsWgtSwJXBipgPW5koC626rEEzqF+d1kqIqmiQLKbxxPU0Kzdt5t3yM1SdWaAKlt0p7TM9CvrcSGMgXz4vhr5Cz7jq+pwMiXOtf0npoqnZEI/LUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757740; c=relaxed/simple;
	bh=N0EtA2vc0rrL6/7QURZ91m+ODlTiqMLjTN8JLgmgwjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLDU9glC3/6aA3iUwAAPmQzrLjMciHP+OH35YQx1tQ8bSBWcPAgrfIzvfAx3mVTCX9E0biRw2CIeQ1IKPW0f06ubqDRsztBDv66SOy4heQx6mXJc0n6PPpCDvHyNrn2w8pTD//hCFy3/BhOqOjLvPvV6KJMyYmSIo9flBQqehP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3D7KJex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3D7KJex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C931F000E9;
	Mon, 29 Jun 2026 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782757739;
	bh=WMJrcrY08ouDvmmmXW++01Gfe5RFBLcdbhyNzxOEky0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l3D7KJexWvNOYTzEGdVVldm8/k4O8fbJxuKVHt3+Jz2EquoFojvJ4WU+Csf9cHENp
	 pluwwvS9nJGIMINJs8smDHtvq5PHP1hVQrcvb13BU4+yjdHhZgf1sai9gxkbPijAlJ
	 WEDwIr0QgYaXNO/LO/+gUcv3VfRTBcvXgudbPJbnpKat2ZuXya3imqGcJxPe0TrQN4
	 3U+Xj/LP3pBWPq8imS7Y9p01roVLHMAJVhqVZ3j9pnLt1F0kLWoG9CnGZQzU3zK8Tq
	 XnAIoQlN7OIaqwzW9neUV0lk7kBXpt1dGGtR1J39Gd+GsjTsKmBlUTN9fU0jlCaPzy
	 CfTKnEnRzKQew==
Date: Mon, 29 Jun 2026 19:28:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org, andy@kernel.org,
 antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, duje@dujemihanovic.xyz,
 jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
 krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
 sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260629192853.0b12a3ba@jic23-huawei>
In-Reply-To: <ajpUa1adlePVuqE1@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
	<20260622221550.374235-2-jakubszczudlo40@gmail.com>
	<ajpO9zaZbIl3x1uC@ashevche-desk.local>
	<20260623112953.000066cc@gmail.com>
	<ajpUa1adlePVuqE1@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 12:39:55 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 23, 2026 at 11:29:53AM +0200, Joshua Crofts wrote:
> > On Tue, 23 Jun 2026 12:16:39 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> 
> ...
> 
> > > > +	return read_poll_timeout(ads1100_new_data_not_ready, data_ready,
> > > > +				 !data_ready, wait_time,  
> > 
> > I'd actually be all for using `data_ready != 0`, to make the condition more
> > readable.  
> 
> I am okay with either. It might be slightly clearer if the comparison is done
> for some dynamic counting or so, when 0 is not special.
> 
> ...
> 
> > > > +		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);    
> > >   
> > > > +    
> > > 
> > > This blank line is not needed as they are coupled, but I don't know if we have
> > > an agreed style in IIO for this.  
> > 
> > I'd be surprised if there was an agreed style, as there aren't any IIO drivers
> > that use this specific macro (not in mainline at least). Additionally, might I
> > suggest using `PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND` as it is more generic?  
> 
> We have other PM_ACQUIRE_*() macros in the drivers in IIO, so we have some style,
> but I haven't checked what is that.
> 
FWIW I'd expect no blank line to be the standard formatting for this.

J

