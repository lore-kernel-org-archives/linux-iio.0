Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8C2264C7;
	Sat, 16 May 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933534; cv=none; b=UYKqs7f2vawYEHan/cwxJ5U+JN1or+28TsEKTpraQmzma5fv8MB3fr8sWadj06AzUfkcHHMZU8rVav7LqYSrLjOsuU4jTTYT0sryrP6I9I0cnzwa9jF0AObXEYGtapiYLvES36AgRaWR7czrspQaCQN5vk7tfRfyGFuXabIBzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933534; c=relaxed/simple;
	bh=iw02GvgfOz6Y8vYRzU4uyBf+jVodLAbtDsvU7P1nDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PigM58l3HxrcdoPsnvkTpk1SJT7I48Kzgzp7ajAxIYqCXbYdaSuC+SYu1VzJ+7UyjYOkNwjpMEO0D9eape1u4EdjX5bGDl3siO+IxY+7Zud2V77CUgoeB9CkvqaIDsf/1oJmxjCVCDGmaBVqdQAnZ1bG8rbjgjacbUikBRSV6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCfkDYLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCfkDYLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E853C19425;
	Sat, 16 May 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778933533;
	bh=iw02GvgfOz6Y8vYRzU4uyBf+jVodLAbtDsvU7P1nDFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCfkDYLx9IDCyMRNvu9P7vZWkAC0hES+yTCsi/i86daZloWGCzULPE2Mm8WPx6q2H
	 Wn33eCMyKHNbTkut7QZ8YICcDiBO9umufP5UdeuFBPU/+ebIDYDx2335Eu+rUNE7l/
	 JD1ZBEKMLiZFcrT0Q6EO23CTjjWWplW/Y+DplgN5odftR6dFhKEPdEXXBNQgaHVBmt
	 6VlhVeiM069hKriTH0n+SBjLWOSPoJh/u5xXss4HqPLZ7KVQzDSvdqQzoOcVhgylHW
	 db9g5HexgXH/qFGx1Fo7l7/7vaYKJlLokbOtW9u1b+BLTP9P2IugbWq9zjwl4JdVOj
	 4q4bRA6nbCibg==
Date: Sat, 16 May 2026 13:12:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-iio@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] iio: light: acpi-als: Check ACPI_COMPANION() against
 NULL
Message-ID: <20260516131206.2fec17b9@jic23-huawei>
In-Reply-To: <agNZtFQ8XP3MTO4i@ashevche-desk.local>
References: <2366919.iZASKD2KPV@rafael.j.wysocki>
	<agNZtFQ8XP3MTO4i@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 19:47:48 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, May 12, 2026 at 06:28:26PM +0200, Rafael J. Wysocki wrote:
> 
> > Every platform driver can be forced to match a device that doesn't match
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companion
> > object need to verify its presence.
> > 
> > Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> > acpi-als IIO driver.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied thanks.

Jonathan
