Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748360;
	b=fVTiW0F2aHfle+QITlDmcfzA+XfIsJiNx4kDj6bbWZP/xe0/EhMlGx1Wk2xO4FrWz256
	 CwCp5+BFP6BSXMLmoy/oTGtV9htZbTf6H7hcsr0lb25lpYtN8/Y/mq2DZroHkOP2OedjE
	 s5o9Xc61DuSVqz27DPtwkPsZTfqn/1/mpdF5WtjME6HPa/O0gV8wGzQG8BPW4c81tcZxE
	 0nlu+VR8fJ0sZcVwPQm69/RBsy6sP/TnkoA+HmS3NA8RVC6EfT4xjjcOjL5zk0+vyKl3D
	 W5URydB+uc3ViZdiRXegLgGRRyrHnRPAUU838a3iPyOgAC1Ne2WM5qdsc+FrJXqnl5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748360;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DU22UVInmllYQO19jWeBnbRddk6N+7Wv5McitbmYGC4=;
	b=ISPJ7hh9jN9F3D0F6BFUGPyIDAwShn2FIhjy8UsrhsBHZFnxauUlr1lfqj3oDT3UaGeu
	 C7ZTS+oY7QkVObJiPbpWUw+AbWyuuLkAbtGbp6gCsMu9pYMftxqXbxkUuJUpt4vgluxR+
	 OdS+HEuwUIsxKHCFwKeRIVRKE2nFh+zX0Moz6enx10wz0B6gd/iSHTbSJIh4UVkRmIN+z
	 KeVy7rhy1DHa9w1TXSJNVTOncHRmblFZMVsWFOLVwGuLAgguiIreHIAQc7HryjusX5g7i
	 znGg44m36qJI/VLfZWXp1SQOm+L4yj54+32wLPxoH9ZohIpFuUljfbAQkCJjM2r1Lug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwN6fxVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F7606A32C;
	Tue,  3 Nov 2026 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwN6fxVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9653B1F000C1;
	Tue,  3 Nov 2026 23:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748359;
	bh=DU22UVInmllYQO19jWeBnbRddk6N+7Wv5McitbmYGC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NwN6fxVdiib4ZM3O5burnvGN3VGytNd1miDpVtRkM6nbe+VL+JRAtzGodTdG4ZiVW
	 +1xH/s+MXwFBcgwKfo6SDoW8dKyhcVOC9qPEJ16vgdZVLbbbkqHvZl1vlUmOZA5Hh3
	 PgVXF+rEqPacp2oYECzmHLLU0OjoZiXj7J7fqrQcH2nHbCjpoGGxMEJmtgDLe2M8c1
	 YVA/qKtkisqtH2UVvez10sE81FwlgxNn3BIE2nWu/ReRtLRr2lXflPtEP+/rOOEjjR
	 ftCLWfBX9X21hAA6CASHZkZuM1E2EhpNenh2J9wl+1cy/WLh6kaw0Ngzms/Gkn3ijd
	 bMM+rAYzVPpdA==
Date: Tue, 3 Nov 2026 23:25:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tristan Madani <tristmd@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tristan@talencesecurity.com
Subject: Re: [PATCH v7] iio: adc: pac1934: validate ACPI _DSM return type
 and bounds
Message-ID: <20261103232552.77b63ea7@jic23-hlaptop>
In-Reply-To: <aupL8Yb61IPDu_hH@ashevche-desk.local>
References: <20261103185026.3139023-1-tristmd@gmail.com>
	<aupL8Yb61IPDu_hH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Nov 2026 23:02:41 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 03, 2026 at 06:50:26PM +0000, Tristan Madani wrote:
> > 
> > pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> > times to read channel configuration but does not validate the returned
> > object type or array bounds:
> > 
> >   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
> >      firmware returns a different type, accessing rez->package.count
> >      and rez->package.elements on a non-package object produces
> >      unpredictable values.
> > 
> >   2. The loop bounds use rez->package.count directly without capping
> >      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
> >      than expected causes writes past the fixed-size labels[],
> >      shunts[], and active_channels[] arrays.
> > 
> >   3. The bipolar and sample rate DSM calls access elements[0] without
> >      verifying package.count >= 1.
> > 
> > Use acpi_evaluate_dsm_typed() with ACPI_TYPE_PACKAGE to validate the
> > return type at evaluation time.  Cap loop iterations to
> > PAC1934_MAX_NUM_CHANNELS, and verify package count >= 1 before
> > accessing elements[0].  
> 
> LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git.

Thanks,

Jonathan

