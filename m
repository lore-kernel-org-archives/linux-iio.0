Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B546261B8D;
	Fri, 25 Sep 2026 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301027; cv=none; b=BQPpJdiOHXPAB6hzfjISwAOdZaL4aDumMoN0tl2NSFrECrHoth2qCy2mS1y0kSEyE7fL/S2/AUoWx+xB1jE2xCp8hujATQD5gZ+WxoKCS0YQjPoeqN/EZm/XJEaGc8TYu8c6bGQa3XdvQj+UNqSKjb8rNNUUsI346XX8lJ0fUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301027; c=relaxed/simple;
	bh=inEqjEpDglLkNFy8nCjjq8+AxguZny3hJWOmKgFbXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSvdACbL9x9mHUP3KUIkVfcomnmfeuyOfYtwzQ+NqfNQ1ywm2QZyVx10bHMR3iRbEspULPscUkkZS1uBI3TX9z+fG0WbEOS0KJ0bSyGrUa2TCp6Jl69GfrB3GGieKOl5oGuWN1IryXZaxDPivJs8iRevZEFK+2MF7volNvXqz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiJe3lmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiJe3lmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EA01F000FF;
	Fri, 25 Sep 2026 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301025;
	bh=shPc3UzugcyGgOmfcjBgifgZgCAQqdOMWi1NcC9UhmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oiJe3lmNBtbp7KchHuNNEBtqDxelaYxf7TG3b2p56vIeiRbC+qcze9E7xljS6Fbt+
	 GLoIB8tqfPqy/6DJoW2x5djnBw0a3DhhJNRfuY+CEpEcmdB9++W+8vB1QECGaJVEPd
	 e31i8JEsfZt4KIkNKHAPCLK5+PCBZp70U+sPvO9WO5Ea5KMWs8gn5S6Wq8UpE/0fJF
	 xEDOielbdp0vMCbLzdxmz1EJIlzC7xRArX7PulHhZyDRrAnkgYfq5+0hN/AWYCLO55
	 etxs+At+bKGbM7kyjmI9dbsDdVk2Onxl2LD2hzW1wsJnCXBg7ZuI188flOyTDN7XnE
	 ygkU9JH0nBUFQ==
Date: Fri, 25 Sep 2026 02:50:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <hppiscas@163.com>, nuno.sa@analog.com,
 michael.hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: cdc: ad7150: fix OF matching and publish module
 aliases
Message-ID: <20260925025022.23fcca59@jic23-hlaptop>
In-Reply-To: <arJX66ZmCWbZ_4RV@ashevche-desk.local>
References: <20260920033303.11879-1-hppiscas@163.com>
	<arJX66ZmCWbZ_4RV@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 13:26:51 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Sep 20, 2026 at 11:33:03AM +0800, Pengpeng Hou wrote:
> > The OF match entries use positional initializers, which initialize the
> > name field rather than compatible. Consequently the advertised AD7150,
> > AD7151 and AD7156 compatible strings do not describe OF compatible
> > matches. The table is also not exported for module alias generation.
> > 
> > Use designated compatible initializers and publish the OF table. Keep
> > the existing I2C ID table and its device-variant selection unchanged.
> > 
> > The issue was found by our static-analysis tool.
> > 
> > Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
> > Assisted-by: gpt 5  
> 
> Assisted-by: LLM
> 
> > Signed-off-by: Pengpeng Hou <hppiscas@163.com>  
> 
> Same to other patches with similar tag.
> 
> ...
> 
> TBH, except the commit message I can't see how LLM could be helpful to the
> code. It's quite a simple change...
> 

Applied with the Assisted by tweaked.

Thanks,

Jonathan


