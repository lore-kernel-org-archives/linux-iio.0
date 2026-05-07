Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25F344DB9
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189348; cv=none; b=hZTOhu0AZBZdKwBqKlito3Lh1ocly7MsUnW2OK0NZA5k1pgb8Sjd+PFq9z27zjovshkylz+TCoLyzwf3E9iNBbmP2RgooDMbOWWVEAy133TklSs8hZTpY3HF81KXd4c/zMYLhgEUdYGjTqM4JTcNHHJpT8AN+wqUD+oUzKS8ji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189348; c=relaxed/simple;
	bh=OKalQ8OEtgyp77igo+KRzfCsoIovhS1lXQCXuo5f1Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XemWGsmrWieUbb594tjvRvR25mfgQC+0TKBNGJiX7sSRuowiUYVoS8LJmOed+fF7c8opagXibF1dMuiiWNP7D1YbMWkCdPyPN3xXlnz7jzwQZZKsOavP6MiQXE0yaRO/UWpsMu00kNMq5f5ycf91rc8TBV8k4tDmjWO5m4Yx2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS/iyfoH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS/iyfoH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe5574cb9so111030f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778189345; x=1778794145; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9uH+ELvCqxW8hGQl0ShIS4MVdmXm1hEW6CsUuEGmV8=;
        b=PS/iyfoH389AqWsUqr0uLaFijutvScLSTOKBX7J7yUQFuEHhhnJobjQpJZbX9C8mLM
         4qH0oq1kJSxA9VZ1wawaWMMZ+RJcW2z6YXJkNAU/Ms06Jt1FxuU0ji/wwrNNTu86q89Z
         xIa3GWgtF0J00vwvDeuFfZW1RGejQmn0Ta/lti1AOB8l39MXMiMDYF+Xe9nUsJRW8gsj
         vuFuJ8LID9/Ue1mnNuKDdKGDEnsqOm1ACUkwdmvjNHsmACU53U/aRCkvvY0tj43U8B2c
         w48NI2oLKPiXs1K/92AJIXG3EqwvXG9CuJ6/SLVPkcXGHkq9ytsVBH7g6M68SatFTcbC
         XATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778189345; x=1778794145;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9uH+ELvCqxW8hGQl0ShIS4MVdmXm1hEW6CsUuEGmV8=;
        b=MbMkEbseQ6VNCKDst4foBLbHBgQhMAVrGb1dL+rutxphGyUk3wfC8ij9o2XBGCtXnY
         6HOEZqMYbTAcUL0paJxOepPka3W/RNMCWLwmuyXuI/3qAF+l/vPJUd27LRLYVfYG419u
         5ahDCHBhMSTQh5VyrNardc4WGWXi2ssAOY4HSmZxwJ5cdeOAO5ihfwo6MFqRZKbine0W
         jcXhN8V1IQ89hPFKbifS4hXwP6dnjXPeWIZpOeUqYoveLxlvB5JhVoVkqZRVp3z1v3M0
         sjlSMj5P5SSW4zsipZM+hN4rwJpd9/E04tDOgPy+DzXdO1VIk2j1106X7eQkDbabwRTm
         vE+w==
X-Gm-Message-State: AOJu0YyfwKJsl3r5DdBj+1bynJWCI0zuPyYUTGFTBbPG7IHUh0pvRGSx
	medyl1snyS7PF/2DBPsy4XPRgpJluK/IYnaoYW96CSvnY+UwSZmYYvGexH9DzoM5
X-Gm-Gg: Acq92OGzf55jWXXh1KZIKUhu1qDzJqwqFVlgLmfMKXswNwgYCpSG6yIXrJElc8TM39v
	g5xucyE8BH+iMITFWtKPwtd4cXaceGq8cWByPlQMNE1vOFFRlqiOf6GRpQ6z9ATReb5v3eT20Ij
	6S22wJ7MbmKoOIJfsa0xzPIMwxUJWyAQO4+oWo8AD71zC4LcUIWaRbd5/1/xYgdWkqsqa7lt72D
	D9rqciIins3J8CgpoOjeJ+Wtkervgo0pPUB/VMQaIYIM+cTHvoaDKFvV9Ixnt892+cJDp7Xsqb/
	d79wI0tgyjwj8Vb1RloaNpQASdWSI0L9ChL2KXMUbbfx2L0gaYw9mLscSZ+chSKMm2hJApIQk+5
	TegetinzT4e3/orCPfLMeJAhxshI3O0Q5vrb4fUBRdlxzqkWk5yvo/ejhHTWTCqNGzvMv5rmcYV
	QD4OezbGmJAA7Wa1Jw7r9dH9QPE6SMqIqFnlx5VlcmWn2yCFbhdyEV+g==
X-Received: by 2002:a05:6000:25c5:b0:44f:62a1:35d2 with SMTP id ffacd0b85a97d-4515dc80ad4mr8179726f8f.3.1778189345268;
        Thu, 07 May 2026 14:29:05 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45417219d58sm1609056f8f.25.2026.05.07.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 14:29:04 -0700 (PDT)
Date: Thu, 7 May 2026 18:28:58 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Subject: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

We have a request to support multiple devices tied together in a single evaluation
board. The goal is to be able to read them simultaneously via the IIO framework,
while also controlling them individually. Currently we have two ADC devices that
would benefit from this, but there might be more in the future.

This is the scenario:

+---------------+                                                 
|     ADC 0     |                                                 
|               |                                                 
|        SYNC_IN|---+---------------------------+                 
|          DRDY0|---|------------------------+  |                 
|               |   |                        |  |   +------------+
|          SCLK0|---|------+                 |  |   |    HOST    |
|           SDI0|---|------|--+              |  |   |            |
|            CS0|---|------|--|-----------+  |  +-->|ADC_SYNC    |
|          DOUT0|---|------|--|--------+  |  |      |            |
|               |   |      |  |        |  |  |      |            |
+---------------+   |      +--|--------|--|--|----->|SCLK        |
                    |      |  +--------|--|--|----->|MOSI        |
+---------------+   |      |  |        |  |  |      |            |
|     ADC 1     |   |      |  |        |  |  |      |            |
|               |   |      |  |        |  |  +----->|DRDY0       |
|        SYNC_IN|---+      |  |        |  +-------->|CS0         |
|          DRDY1|---|------|--|----+   +----------->|MISO0       |
|               |   |      |  |    |                |            |
|          SCLK1|---|------+  |    |                |            |
|           SDI1|---|------|--+    +--------------->|DRDY1       |
|            CS1|---|------|--|-------------------->|CS1         |
|          DOUT1|---|------|--|-------------------->|MISO1       |
|               |   |      |  |                     |            |
+---------------+   |      |  |                     | .          |
                    |      |  |                     | .          |
       ...          |      |  |                     | .          |
                    |      |  |                     |            |
+---------------+   |      |  |            +------->|DRDYN       |
|     ADC N     |   |      |  |            | +----->|CSN         |
|               |   |      |  |            | | +--->|MISON       |
|        SYNC_IN|---+      |  |            | | |    |            |
|          DRDYN|----------|--|------------+ | |    +------------+
|               |          |  |              | |                  
|          SCLKN|----------+  |              | |                  
|           SDIN|-------------+              | |                  
|            CSN|----------------------------+ |                  
|          DOUTN|------------------------------+                  
|               |                                                 
+---------------+                                                                                                    

To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
is to allow users to aggregate these devices so they can be read simultaneously
from the user space.

I found a similar case here involving the AD4880 (ad4080 driver), which consists
of two independent ADC channels, each with its own SPI interface for configuration.
In that instance, the ancillary device feature was used because it was considered
the approach of a single device with independent channels rather than independent
devices connected together. Additionally, the backend handled the buffered data
aggregation.

However, I would like to discuss a more generic approach to support device aggregation
across different drivers. Marcelo suggested a while ago to consider the components
framework. This would allow us to create a virtual device responsible for 
aggregating and controlling the sub-devices in a standard yet flexible manner.

The aggregate driver could either be an extension to the main driver (e.g. ad7768-1.c),
or a separate file (e.g. ad7768-1-agreegator.c). 

Here's an example of how the devicetree would look like: 
(includes the multiple data lanes feature)

spi {
    #address-cells = <1>;
    #size-cells = <0>;

    /* AD7768-1 physical devices */
    adaq7768_1_0: adaq7768-1@0 {
	compatible = "adi,adaq7768-1";
	reg = <0>;  /* CS0 - First physical device */
        spi-tx-lane-map = <0>;
        spi-rx-lane-map = <0>;
	/* other properties */
    };

    adaq7768_1_1: adaq7768-1@1 {
        compatible = "adi,adaq7768-1";
        reg = <1>;  /* CS1 - Second physical device */
        spi-tx-lane-map = <0>;
        spi-rx-lane-map = <1>;
        /* other properties */
    };

    adaq7768_1_2: adaq7768-1@2 {
        compatible = "adi,adaq7768-1";
        reg = <2>;  /* CS2 - Third physical device */
        spi-tx-lane-map = <0>;
        spi-rx-lane-map = <2>;
        /* other properties */
    };

    adaq7768_1_3: adaq7768-1@3 {
        compatible = "adi,adaq7768-1";
        reg = <3>;  /* CS3 */
        spi-tx-lane-map = <0>;
        spi-rx-lane-map = <3>;
        /* other properties */
    };

    /* AD7768-1 aggregator/virtual device */
    quad_adaq7768: ad7768-1-aggregator@4 {
        compatible = "adi,ad7768-1-aggregator";
        reg = <4>; /* ? */

        adaq7768-components = <&adaq7768_1_0>, <&adaq7768_1_1>, <&adaq7768_1_2>, <&adaq7768_1_3>;
        
    };
        
};

Is it ok to proceed with component helper for this purpose or do we have something
better? If yes, I have some following questions:

-> How to read all devices simultaneously in buffer mode given we can't assert 
all CS from the virtual device?

-> Should the physical devices be registered in IIO during probe, or should only
the aggregator be exposed to control attributes and general configuration?

Regards,
Jonathan S.

