Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920372DC35C;
	Sat,  7 Mar 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886011; cv=none; b=TR4fi8bgz+akttb+WttJMJz490HSPo+/wSNpeVBvyfsrXDZZ2Zg/pZLZ9vevPFm20/lmAgAmx9pe+u9xPMRuzWdThuw1mQCdK400NAL9gc5z6CoN4VsfgXE/fnYizuVjvjkrQSfo1x/nZjRiAuiKh/dUrytDCBlXDvLU9Zjen6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886011; c=relaxed/simple;
	bh=jiRi92ztOe93ijqJqbf1JgES37OuCVHNCdB1G3L9DHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0zPo/+G4drnKandwVssxMkJdpaxRPrQDuLyuVSJstzeKe5ealyDuLPBYHsyWeinOmss4GbgN/m6dQ8gmwZjX8cc/2HAJkBAZbYm4nlMxMCToNe2QnKwCZLAslAX8CvbamQKahrdY0Aueh7lubLyquzMbGbMRwLpafEMqvzH4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cetPOPQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cetPOPQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF33C19422;
	Sat,  7 Mar 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772886011;
	bh=jiRi92ztOe93ijqJqbf1JgES37OuCVHNCdB1G3L9DHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cetPOPQ0ZNK4yOirBNPB69Ea2YnkkhQaB+fPZVxot6FHiv+u2MVOjF5N1Kda+amYg
	 /R/K8smNfGCQfpzhh+Xj5ADcrHx4+uEkSlTzNcqlZWL70kiRjYWq4/WvbRsjZ6AQRe
	 b6t5ENr22YsBM4pXX+iQphHJKdKQuJ9UJAbfcsyFfTzl0kH4y117HYfTq5Kan0h92P
	 RAs2mI/Tqu/QyHNnNAD492ituRYJyWAYrm6yyViRCG08nEhZ7g+kBtJ2A0f2ZLaR/0
	 1cHtUtp61DoMXM+YCiLi7xmqG7BqAtuQipzN8wYAdhkZ127/envQnxNq7ykkQlUt+Q
	 YX22ldal9FO0w==
Date: Sat, 7 Mar 2026 12:20:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: light: acpi-als: Convert ACPI driver to a
 platform one
Message-ID: <20260307122003.691e2478@jic23-huawei>
In-Reply-To: <aakseadAuKEMAmvq@ashevche-desk.local>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
	<3609079.QJadu78ljV@rafael.j.wysocki>
	<aakseadAuKEMAmvq@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 09:10:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 04, 2026 at 07:33:14PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > 
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> > 
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the ACPI ambient light sensor driver to a
> > platform one.
> > 
> > After this change, the subordinate IIO device will be registered under
> > the platform device used for driver binding instead of its ACPI
> > companion.
> > 
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.  
> 
> ...
> 
> > -static struct acpi_driver acpi_als_driver = {
> > -	.name	= "acpi_als",
> > -	.class	= ACPI_ALS_CLASS,
> > -	.ids	= acpi_als_device_ids,
> > -	.ops = {
> > -		.add	= acpi_als_add,
> > -		.remove	= acpi_als_remove,
> > +static struct platform_driver acpi_als_driver = {
> > +	.probe = acpi_als_probe,
> > +	.remove = acpi_als_remove,
> > +	.driver = {
> > +		.name = "acpi_als",
> > +		.acpi_match_table = acpi_als_device_ids,
> >  	},
> >  };  
> 
> >    
> 
> You can also drop this unneeded blank line.
> 
> > -module_acpi_driver(acpi_als_driver);
> > +module_platform_driver(acpi_als_driver);  
> 
> Anyways, LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tweaked and applied to the testing branch of iio.git.

Thanks,

Jonathan

> 

