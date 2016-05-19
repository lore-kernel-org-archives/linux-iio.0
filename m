Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAKzfze_cJQXrb4789WpOjpWeLO3PEotuDnKc+FRd4FiFUOuYJA@mail.gmail.com>
References: <CAKzfze_cJQXrb4789WpOjpWeLO3PEotuDnKc+FRd4FiFUOuYJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] dynamic iio consumer channel mapping
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 19 May 2016 06:58:33 +0100
To: Matt Ranostay <mranostay@gmail.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,Jonathan Cameron <jic23@kernel.org>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <2C047EEE-7F16-4B5D-A735-301B4AE788CC@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 19 May 2016 04:38:09 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>Jonathan et al,
>
>Shortly going to be doing a project that requires an iio_map mapping
>for using an iio  channel input from an ADC. I've notice all seem to
>be platform_data or hardcoded due to it being a SoC or statically
>known MFD mapping.
>
>For my application it isn't correct to create an hardcoded iio_map
>mapping with the ADC driver (ti-ads1015) since nobody else would care
>about it, and wouldn't help in the case of multiple instances of the
>same ADC.
>
>But I would rather avoid the technical debt and uglyness of using a
>board file.
>
>What would be the best way via ACPI and DT to define channel mappings
>between name, consumers, and consumer channel names? Thought I request
>input here before I make any core iio subsystem changes.
>
>Thanks,
>
>Matt

Whilst we have gotten a fair bit of grief over the Linux specific nature of the
 binding, iio-hwmon does have bindings for this sort of case.

Mid term I have been wondering about taking it as far as having a configfs
 interface to create such soft hardware mappings at runtime....

J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
