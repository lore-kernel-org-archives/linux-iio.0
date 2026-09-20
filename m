Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CAA324B20;
	Sun, 20 Sep 2026 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789869921; cv=none; b=D6U0GL1vyt+auKXsNmw8bI1OepOIMAMzlpk3fp4lRpGld7KoPjMXvkp+4zeZeTVhO3RKduRV87+eG5yabWc5Df1DDUXN9Ow4mp3Go0lf4SVllCesxFoXV2TaYRM8AKXXei9Hs3ZZ7w9qOqo6kYARaFcYsDbbacI+p+Sm+GeVwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789869921; c=relaxed/simple;
	bh=YoGLxu99tj8cwlU9swRsguoBv675SzXyQMz4g2koU+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iav89BhiwndafKtwKkYEJJZwXByWF++BW445iaoKTPd6xsXFIG4agakOgE/1mZIjYVHbyfXwDrzZljt7XHo0iSt5lE5lD8/oSiwEhjasdzp+Y8tTd5HHTbAIjhIjScgi1DIce6gV0OSCnZZGoXO7oq1D/2k8hWp6+zUhLApx4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaqjKk4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaqjKk4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907981F000FF;
	Sun, 20 Sep 2026 02:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789869919;
	bh=FzsxO+Z5PgBv9Dc0FBb47dkgp365lg2VvwmJMdZ2vhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WaqjKk4/K7bo+F5lWOuGsMf52eSSZ90Hcn/8sz63LJVNtJzXGzZKlZbSraMM5ZdGZ
	 VcRYNQCsD+kWMDih/beWULahZa3+VBVzqGsg96fy9R7R62AUlehcCYa5DvR+UXqpbh
	 utszLfB5SIT8kwK1CrA2Q4uoV1zPn181j/PtTnPTwVO5GnMAV5aTe01gdDbU19+JLv
	 osUpNMRnmXP+BYT3D/5PZKCefe9oWV/DM1T5Qz9XXB1Quygc2jENgxBUjUAAfyf0v4
	 htH/FHsz2We3NzhVnuy7NThLFWyI/yUBo4Yx+qUXsNx8HC5I/rE5CBCFOkshIVN/j7
	 0F2SVzFb04M/A==
Date: Sun, 20 Sep 2026 03:05:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 0/8] iio: add Open Sensor Fusion UART support
Message-ID: <20260920030512.50f4f988@jic23-hlaptop>
In-Reply-To: <cover.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:38 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Specification status: OSF-D2H 0.0 spec-1 has completed project technical
> stability review, has been adopted by the project owner, and is published
> as a fixed specification.
> 
> Canonical specification:
> https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/spec/osf-d2h-0.0.md
> 
> Errata process:
> https://github.com/opensensorfusion/opensensorfusion-protocol/blob/ca9cdea1ae550c2b4d6f29f87877adae99470744/errata/README.md
> 
> Current adoption/publication record:
> https://github.com/opensensorfusion/opensensorfusion-protocol/blob/0cabccf63ac01d0eb82dd9882739ff58eed4a76c/reviews/publication-record-20260918.md
> 
> The specification was frozen before adoption/publication, so its embedded
> status snapshot is intentionally historical. The dated publication record
> above establishes the current adopted/public state. This is project review
> and adoption, not an external maintainer approval.
> 
> This series adds the Open Sensor Fusion UART receive path and IIO devices
> discovered from capability reports. It exposes accelerometer, gyroscope,
> magnetometer and temperature data through RAW/SCALE and buffered scans.
> Device Tree describes the sensor hub; its individual streams are discovered
> at runtime.
> 
> The receiver validates supported descriptors and sample scales, keeps
> discovery open after empty or unsupported initial inventories, and checks
> repeated inventories before allowing new data to use registered metadata.
> A supported descriptor changing meaning faults the session until an
> explicit teardown and rebind. Existing v9 cache, scan-layout and buffer
> lifetime fixes are retained.
> 
> Based on Jonathan Cameron's IIO testing branch:
> 69fa76f0af3414cc189c3b0b807cb59e327ecc00
> 
> Changes since v9:
> - Publish and reference the reviewed/adopted OSF-D2H 0.0 specification,
>   errata process and dated publication evidence.
> - Tolerate reserved padding, validate descriptor/sample scales, keep
>   discovery open after empty/unsupported reports, and compare repeated
>   capability reports.
> - Fail closed on changed descriptor meaning instead of publishing data
>   with stale metadata.
> - Add focused KUnit coverage for these lifecycle and validation cases.
> - Use managed UART/IIO/power teardown and dev_warn_probe() for the
>   controller baud-rate warning, addressing Andy's probe-path feedback.
> - Split the former combined UART/core/IIO driver patch into transport/core,
>   IIO registration, core KUnit, and IIO KUnit patches following review.
> - Use validated/unvalidated terminology for framing/CRC results throughout
>   the stream/core/transport code, tests and diagnostics. CRC detects
>   accidental corruption; it does not provide cryptographic authentication.
> 
> Prior validation on the identical source tree:
> identical source tree evidence reused; no builds rerun for DCO packaging.
> - All eight intermediate apply/config/relevant builds.
> - Independent transport/core and IIO module link/MODPOST.
> - GCC/Clang W=1 vmlinux and modules.
> - GCC and Clang KUnit: core 16 + IIO 2, all 18 pass in each run.
> - Core-only intermediate KUnit: all 16 pass.
> - ARM64 Image, selected OSF module and Pi4 DTB.
> - Targeted DT binding/style and IIO documentation.
> 
> The terminology-only diff was verified mechanically. Wire semantics and
> data-path behavior are unchanged; the receive diagnostic key is validated=.
> Hardware testing was not repeated for this terminology revision or this
> post-DCO packaging audit; previous hardware evidence remains historical.
> 
> Human DCO is complete. No email has been sent.
> 
> Jinseob Kim (8):
>   dt-bindings: iio: add Open Sensor Fusion device
>   Documentation: iio: add Open Sensor Fusion driver overview
>   iio: osf: add protocol decoding
>   iio: osf: add validated stream parser
>   iio: osf: add UART transport and core receive path
>   iio: osf: add IIO devices from capability reports
>   iio: osf: add core KUnit tests
>   iio: osf: add IIO KUnit tests
> 
>  .../bindings/iio/opensensorfusion,osf.yaml    |   52 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  Documentation/iio/index.rst                   |    1 +
>  Documentation/iio/open-sensor-fusion.rst      |   77 ++
>  MAINTAINERS                                   |    8 +
>  drivers/iio/Kconfig                           |    1 +
>  drivers/iio/Makefile                          |    1 +
>  drivers/iio/opensensorfusion/Kconfig          |   27 +
Any reason not to push it one level deeper and put it under IMUs?
I'm not that keen to grow the top level menu for this as all the
other entries are about type of sensor, not one specific sensor.

