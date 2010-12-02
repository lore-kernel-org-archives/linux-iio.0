Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
CC: drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org
Subject: [RFC] IIO: ABI for Direct digital synthesis (DDS) devices
Date: Thu, 2 Dec 2010 13:21:26 +0100
Message-ID: <1291292489-32362-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

[RFC] IIO: ABI for Direct digital synthesis (DDS) devices

Direct digital synthesis (DDS) is a technique for using digital data
processing blocks as a means to generate a frequency- and phase-tunable
output signal referenced to a fixed-frequency precision clock source.

[RFC 1/3] IIO: Direct digital synthesis abi documentation
	Proposed ABI documentation

[RFC 2/3] IIO: dds.h convenience macros
	Attributes considered as common between various DDS devices

[RFC 3/3] IIO: DDS: AD9833 / AD9834 driver
	Example driver using the proposed ABI

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
