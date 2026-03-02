Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174B1DF980;
	Thu,  2 Apr 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089921; cv=none; b=KvFTWodiUT7Wx9g1kiyM70ZjNQdR+4HvfzozUjSYRiKp2oX1TFAJv+MtYPl6qHUoo+6cwX7n2NyHKaU8QTxqmnWDR5uFH+WJgyFFph4J9+z8tXji06/au9T7Rnc2heAtSysSZwpqIeHnJMpF7URtx+oo+MKLzQgg1wZPbJS1JQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089921; c=relaxed/simple;
	bh=JedCIr8sS5Z1m5aJv7FIyn2/V9isGdx9QvtFBBif2kI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWH8RboaUw4usDOePyNho3uCZocTydNWeSzAWj7yslnA1E7j6IiNl69bpW3JFXEf4DwkoF0wA6zHOJ7fISED+oqxIeVHOiSLdD6XacsJzCPILYI+UT2wbELP3UcF6VMo0JSAyVP1OGeTElM/5EXM3dILZHcd8KPX3Xw9fS2ClVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAafiF8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAafiF8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23572C4CEF7;
	Thu,  2 Apr 2026 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775089921;
	bh=JedCIr8sS5Z1m5aJv7FIyn2/V9isGdx9QvtFBBif2kI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rAafiF8ZIkAv2nj6im1kEc9hij4Ko5nNEbyjZilKb+I7mUCE2YHwP78yUXTF4mHvl
	 ObTjUxXV0/vnaDtjHQ9Nna6Cpr/bRyp+BSjWbYtjLDQq68q7N6adz/r0htFOJyez5u
	 H7OxOPZnd6p7KEy/GkEIe4BUHhXrA5XkVIr/4pm8XnRMJDA3iRq3kYfifxCWnUwcfN
	 XTslxGNpHmy1mHhab+PRVtJvvSBcR6R8WhbfKvziQ1eS4B3GCF/J3/3QrrPDkK1Ip7
	 ZQXdbi9K7j5R5Uj0Bv+Bo4oJU1PjYYIW4+VGsnKXJpAHgtkYTGa8nneqns6LvXCxQn
	 lGSl13FlxAoUw==
Date: Mon, 2 Mar 2026 19:50:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Drop redundant error message
Message-ID: <20260302195003.7f50b2b8@jic23-huawei>
In-Reply-To: <aaXFopIcpsWGjzX7@ashevche-desk.local>
References: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
	<aaXFopIcpsWGjzX7@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 19:15:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 03, 2026 at 01:07:29AM +0800, Felix Gu wrote:
> > devm_request_threaded_irq already prints an error message when failure,
> > so the error message is redundant, drop it.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git.

Thanks,

Jonathan
