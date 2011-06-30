Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Thu, 30 Jun 2011 15:04:31 +0100
Subject: const members of struct iio_chan_spec?
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713EA0BC56E5@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

static int ad7280_channel_init(struct ad7280_state *st)
{
        int dev, ch, cnt;

        st->channels =3D kzalloc(sizeof(*st->channels) *
                        ((st->slave_num + 1) * 12 + 1), GFP_KERNEL);
        if (st->channels =3D=3D NULL)
                return -ENOMEM;

        for (dev =3D 0, cnt =3D 0; dev <=3D st->slave_num; dev++)
                for (ch =3D AD7280A_CELL_VOLTAGE_1; ch <=3D AD7280A_AUX_ADC=
_6; ch++, cnt++) {
                        st->channels[cnt].type =3D IIO_IN;
                        st->channels[cnt].indexed =3D 1;
                        st->channels[cnt].extend_name =3D NULL;
                        st->channels[cnt].channel =3D cnt;
                        st->channels[cnt].info_mask =3D (1 << IIO_CHAN_INFO=
_SCALE_SHARED);
                        st->channels[cnt].address =3D dev << 8 | ch;
                        st->channels[cnt].scan_index =3D cnt;
                        st->channels[cnt].scan_type.sign =3D 'u';
                        st->channels[cnt].scan_type.realbits =3D 12;
                        st->channels[cnt].scan_type.storagebits =3D 32;
                        st->channels[cnt].scan_type.shift =3D 0;
                }
        return cnt;
}

Trying to dynamically allocate and populate a channel spec.
However some members are declared const. Do they really need to be const?

drivers/staging/iio/adc/ad7280a_core.c: In function 'ad7280_channel_init':
drivers/staging/iio/adc/ad7280a_core.c:231: error: assignment of read-only =
member 'info_mask'

Regards,
Michael

------------------------------------------------------------------
********* Analog Devices GmbH
**  *****
**     ** Wilhelm-Wagenfeld-Strasse 6
**  ***** D-80807 Munich
********* Germany
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer: Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Ma=
rgaret Seif
