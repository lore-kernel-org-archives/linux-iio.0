Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35077 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733158AbeKMXcd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Nov 2018 18:32:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so5743993edx.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Nov 2018 05:34:23 -0800 (PST)
Subject: Re: [PATCH v2] iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong
 values for signed numbers
To: Bastien Nocera <hadess@hadess.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
References: <20181031142005.15802-1-hdegoede@redhat.com>
 <4990a4a867c57493e5ed525a8df5142281958393.camel@hadess.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e67ee29a-8451-e9c0-5839-262ce56898e3@redhat.com>
Date: Tue, 13 Nov 2018 14:34:20 +0100
MIME-Version: 1.0
In-Reply-To: <4990a4a867c57493e5ed525a8df5142281958393.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 13-11-18 14:09, Bastien Nocera wrote:
> On Wed, 2018-10-31 at 15:20 +0100, Hans de Goede wrote:
>> Before this commit sensor_hub_input_attr_get_raw_value() failed to
>> take
>> the signedness of 16 and 8 bit values into account, returning e.g.
>> 65436 instead of -100 for the z-axis reading of an accelerometer.
> 
> Anything I need to change in iio-sensor-proxy for this?

No, AFAICT all hid sensors offer the buffered API, so iio-sensor-proxy
will prefer that. This is also likely the cause of why this was not
caught earlier.

Regards,

Hans
