Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34947 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbcESDiv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2016 23:38:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id ww9so24146979lbc.2
        for <linux-iio@vger.kernel.org>; Wed, 18 May 2016 20:38:50 -0700 (PDT)
MIME-Version: 1.0
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 18 May 2016 20:38:09 -0700
Message-ID: <CAKzfze_cJQXrb4789WpOjpWeLO3PEotuDnKc+FRd4FiFUOuYJA@mail.gmail.com>
Subject: [RFC] dynamic iio consumer channel mapping
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan et al,

Shortly going to be doing a project that requires an iio_map mapping
for using an iio  channel input from an ADC. I've notice all seem to
be platform_data or hardcoded due to it being a SoC or statically
known MFD mapping.

For my application it isn't correct to create an hardcoded iio_map
mapping with the ADC driver (ti-ads1015) since nobody else would care
about it, and wouldn't help in the case of multiple instances of the
same ADC.

But I would rather avoid the technical debt and uglyness of using a board file.

What would be the best way via ACPI and DT to define channel mappings
between name, consumers, and consumer channel names? Thought I request
input here before I make any core iio subsystem changes.

Thanks,

Matt
