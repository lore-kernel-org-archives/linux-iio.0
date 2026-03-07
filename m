Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE02330B2F;
	Sat,  7 Mar 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886104; cv=none; b=br0aAej6FWel7ZHsBJFBE4ChOjvOA/r4DLg0QjYYQT+BC3JKdWBxcZ6VzNRWxBU5Ou2Ia3CvsUqMQHaM3Oh+Ln5xyrOjPAqdUTxB2ZSzOWHIF+dBPe9k4kI7eCUMe5wlWNAu0BJtI/OfWaxPtNwurDW82d+gfm6L0vAiPfZqqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886104; c=relaxed/simple;
	bh=7owkRNPvB7Q6hbMGb+aLAe2DhVztwY3ImJl15C8aD40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6R03ejcQySLo/nLDyiY3GxpwKArMQm5D4svAIv9ZnSCE9sDpcI6c1r9aosgsXnUILOhzJUVStoEpXYgdoFc5VH/x03IQFYubdKilwxJuDUYbw33BRkpL9qF1JKEUaDxGejrahivoCsWhnj7ZkXwJJW22ywgBM1XSnhVizsTbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXslT74p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXslT74p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EDDC19422;
	Sat,  7 Mar 2026 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772886104;
	bh=7owkRNPvB7Q6hbMGb+aLAe2DhVztwY3ImJl15C8aD40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXslT74pXFP0HFGpsj++TYVu/Ae5kn0T8pFXL0G3CEmXNJLQ7DsOIOFgpJu3zRsKY
	 cb9yOw2v2C/Z7q1Arl7yr5KPzN7zh0LZNkghhT55VuE2hjmLNQeXketZwR3sxu3NwX
	 VZ3+KGJnjmP9GQ8kkGc+UZ1YGOGz6/UqIwbSdGPI/3Z16Jm+ai+v9f8wFzekDrbbNs
	 bGWALR7d1NMRY8SBAlmf29b0AR8nShqAhRDLBHuuSFt1u63r7oMUETQCKyA+9vJQ43
	 L+bQc1oJXt28+dwNGledkcslkepzsjgXjfpKcSKFdm1jtQaJdBs/DqOCFC8XGvlD5J
	 6+wswzdJwTAbQ==
Date: Sat, 7 Mar 2026 12:21:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
 linux-iio@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Message-ID: <20260307122138.74c8b767@jic23-huawei>
In-Reply-To: <0024f138-a8f6-48a2-a68e-a8c36e542b5a@baylibre.com>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
	<20260304122509.67931-2-johnerasmusmari.geronimo@analog.com>
	<0024f138-a8f6-48a2-a68e-a8c36e542b5a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 18:11:22 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/4/26 6:25 AM, John Erasmus Mari Geronimo wrote:
> > Add device tree binding documentation for the Analog Devices
> > MAX30210 temperature sensor.
> > 
> > Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> > ---
> >  .../iio/temperature/adi,max30210.yaml         | 62 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> > new file mode 100644
> > index 000000000000..66867880a20f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2026 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/adi,max30210.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX30210 Temperature Sensor
> > +
> > +maintainers:
> > +  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> > +
> > +description: |
> > +  The MAX30210 is a temperature sensor with an I2C interface.
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max30210
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: Analog supply voltage input.  
> 
> The description makes it sound like there could be other supplies,
> but there aren't. It is the "everything" supply, so we can just
> call it the power supply.

I think

   vdd-supply: true

is also fine when it's a simple as this.

Jonathan


> 

